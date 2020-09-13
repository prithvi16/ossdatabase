class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
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
    @projects = @q.result(distinct: true).page params[:page]
  end

  private

    def project_params
      params.require(:project).permit(:name, :description, :first_release, :last_release, :premium, :website, tag_ids: [])
    end
end
