class PagesController < ApplicationController
  def home
    @license_tag_options = Tag.where(tag_type: "license").map { |t| [t.name, t.id] }
    @tech_tag_options = Tag.where(tag_type: "tech").map { |t| [t.name, t.id] }
    @usecase_tag_options = Tag.where(tag_type: "usecase").map { |t| [t.name, t.id] }
    @platform_tag_options = Tag.where(tag_type: "platform").map { |t| [t.name, t.id] }
    @projects = Project.all.includes([:avatar_attachment]).page params[:page]
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
