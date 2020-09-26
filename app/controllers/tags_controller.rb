class TagsController < ApplicationController
  def index
    @tags_list = Tag.all
  end

  def show
  end
end
