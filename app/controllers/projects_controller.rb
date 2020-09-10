class ProjectsController < ApplicationController
  def new
  end

  def show
  end

  def create
  end

  def search
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).page params[:page]
  end
end
