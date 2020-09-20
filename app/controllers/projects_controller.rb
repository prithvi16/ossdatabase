class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :edit]
  def new
    @project = Project.new
  end

  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
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
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).where(visible: true).page params[:page]
  end

  private

    def set_project
      @project = Project.friendly.find(params[:id])
      if @project.invisible?
        render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      end
    end

    def project_params
      params.require(:project).permit(:name, :description, :first_release, :last_release, :premium, :website, tag_ids: [])
    end
end
