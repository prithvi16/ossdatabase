class PagesController < ApplicationController
  def home
    @recently_added_projects = Project.includes([:tags, :taggings]).order(created_at: :desc).limit(10)
  end

  def static
    @static_page = StaticPage.find_by(key: params[:key])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    if @static_page.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      nil
    end
  end
end
