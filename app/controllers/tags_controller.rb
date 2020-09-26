class TagsController < ApplicationController
  def index
    @tags_list = Tag.all
  end

  def show
    @tag = Tag.find_by(name: params[:tag_name])
    @tag_projects = @tag.projects.includes([:taggings, :tags]).page params[:page]
  end
end
