class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :edit, :preview]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :only_admin, only: [:edit, :update, :new, :create]

  def new
    @project = Project.new
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
    if params.key?(:q)
      if params[:q][:name].present?
        ahoy.track "search", query: params[:q][:name]
        @projects = Project.pg_search_by_name(params[:q][:name]).page params[:page]
      else
        @projects = Project.all.order(created_at: :desc).page params[:page]
      end
    else
      @projects = Project.all.order(created_at: :desc).page params[:page]
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
    @license_tag_options = Tag.where(tag_type: "license").map { |t| [t.name, t.id] }
    @tech_tag_options = Tag.where(tag_type: "tech").map { |t| [t.name, t.id] }
    @usecase_tag_options = Tag.where(tag_type: "usecase").map { |t| [t.name, t.id] }
    @platform_tag_options = Tag.where(tag_type: "platform").map { |t| [t.name, t.id] }
    if params.key?(:search)
      tag_filters = []
      tag_list = %w[license_tag_ids tech_tag_ids usecase_tag_ids platform_tag_ids]
      tag_list.each do |tag_type|
        if params[:search][tag_type].present?
          tag_filters = tag_filters + params[:search][tag_type]
        end
      end
      @projects = Project.all
      if params[:search][:pg_search_by_name].present?
        @projects = @projects.pg_search_by_name(params[:search][:pg_search_by_name]).reorder(nil)
        ahoy.track "search", query: params[:search][:pg_search_by_name]
      end
      @projects = @projects.filter_by_tag_ids(tag_filters) if tag_filters.length > 4
      @projects = @projects.where(proprietary: false) if params[:search][:proprietary].present? &&  ActiveRecord::Type::Boolean.new.cast(params[:search][:proprietary])
      @projects = @projects.includes([:avatar_attachment]).page params[:page]
    else
      @projects = Project.all.order(updated_at: :desc).includes([:avatar_attachment]).page params[:page]
    end
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
