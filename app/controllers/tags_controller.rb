class TagsController < ApplicationController
  def index
    @tags_list = Tag.all
  end

  def show
    @tag = Tag.find_by(name: params[:tag_name])
    if @tag.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return
    end
    @tag_projects = @tag.projects.includes([:taggings, :tags]).page params[:page]
  end
end
