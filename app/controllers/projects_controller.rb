class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :edit]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :only_admin, only: [:edit, :update]

  def new
    @project = Project.new
  end

  def show
    @related_projects = Project.filter_by_tag_ids(@project.tag_ids.map { |e| e.to_s })
  end

  def edit
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
      redirect_to @project
    else
      render :new
    end
  end

  def search
    @q = Project.new(search_project_params)
    @projects = Project.filter(search_project_params).page params[:page]
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
    params.require(:project).permit(:name, :tag_line, :description, :first_release, :last_release, :premium, :website, tag_ids: [])
  end
end
