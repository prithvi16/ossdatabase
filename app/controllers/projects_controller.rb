class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :edit, :preview]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :is_user_admin, only: [:edit, :update, :new, :create]

  def new
    @project = Project.new
    if params.key?(:submission_id)
      @submission = Submission.find(params[:submission_id])
      @project.name = @submission.name
      @project.tag_line = @submission.tagline
      @project.description = @submission.description
      @project.website = @submission.website
      @project.proprietary = @submission.proprietary
      @project.premium = @submission.premium
      @project.repo_url = @submission.github_url
      @project.logo_url = @submission.logo_url
    end
    @tag_options = TOP_TAG_TYPES.map { |tag_type| [tag_type, Tag.where(tag_type: tag_type).map { |tag| [tag.name, tag.id] }] }
  end

  def show
    @alternative_projects = Project.filter_by_any_of_tag_ids(@project.usecase_tags.map { |tag| tag.id.to_s }).where.not(id: @project.id)
  end

  def edit
    @tag_options = TOP_TAG_TYPES.map { |tag_type| [tag_type, Tag.where(tag_type: tag_type).map { |tag| [tag.name, tag.id] }] }
  end

  def preview
    render ::ProjectComponent.new(project: @project, current_user: current_user), content_type: "text/html", layout: false
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render "edit"
    end
  end

  def search_suggestions
    render ::NavSearchResultComponent.new(results: Project.search_suggestions(params[:query])), layout: false, content_type: "text/html"
  end

  def nav_search
    set_tag_options
    track_search_query(params)
    @projects = Project.search(params)

    if turbo_frame_request?
      render partial: "pages/search_results", locals: {projects: @projects}
    else
      render "nav_search"
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      if @project.logo_url.present?
        FetchProjectLogoWorker.perform_async(@project.id)
      end
      redirect_to @project
    else
      render :new
    end
  end

  private

  def search_project_params
    params[:project].nil? ? nil : params.require(:project).permit(:name, tag_ids: [])
  end

  def set_project
    @project = Project.friendly.find(params[:id])
    if @project.invisible? || @project.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  def project_params
    params.require(:project).permit(:name, :source, :source_id, :repo_url, :tag_line, :description, :proprietary, :avatar, :premium, :website, :logo_url, tag_ids: [])
  end
end
