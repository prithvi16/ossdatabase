class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :edit]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :only_admin, only: [:edit, :update, :new, :create]

  def new
    @project = Project.new
    @tag_options = TOP_TAG_TYPES.map { |tag_type| [tag_type, Tag.where(tag_type: tag_type).map { |tag| [tag.name, tag.id] }] }
  end

  def show
    @alternative_projects = Project.filter_by_tag_ids(@project.usecase_tags.map { |tag| tag.id.to_s })
  end

  def edit
    @tag_options = TOP_TAG_TYPES.map { |tag_type| [tag_type, Tag.where(tag_type: tag_type).map { |tag| [tag.name, tag.id] }] }
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render "edit"
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

  def search
    @tag_options = TOP_TAG_TYPES.map { |tag_type| [tag_type, Tag.where(tag_type: tag_type).map { |tag| [tag.name, tag.id] }] }
    @q = Project.ransack(params[:q])
    @projects = @q.result.includes(:taggings, :tags, :avatar_attachment).page params[:page]

    respond_to do |format|
      format.js { render ProjectListComponent.new(project_list: @projects), layout: false, content_type: "text/html" }
      format.html { render :search }
    end
  end

  private

  def search_project_params
    params[:project].nil? ? nil : params.require(:project).permit(:name, tag_ids: [])
  end

  def only_admin
    if !current_user.admin?
      render plain: "Not allowed", status: :forbidden
    end
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
