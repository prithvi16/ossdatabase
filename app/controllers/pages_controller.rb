class PagesController < ApplicationController
  def home
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).order(updated_at: :desc).includes(:taggings, :avatar_attachment, :tags).page params[:page]
  end

  def static
    @static_page = StaticPage.find_by(key: params[:key])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    if @static_page.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      nil
    end
  end

  def subscribed
  end
end
