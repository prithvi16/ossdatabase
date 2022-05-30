class PagesController < ApplicationController
  def home
    @license_tag_options = Tag.where(tag_type: "license").map { |t| [t.name, t.id] }
    @tech_tag_options = Tag.where(tag_type: "tech").map { |t| [t.name, t.id] }
    @usecase_tag_options = Tag.where(tag_type: "usecase").map { |t| [t.name, t.id] }
    @platform_tag_options = Tag.where(tag_type: "platform").map { |t| [t.name, t.id] }
    tag_filters = []
    tag_list = %w[license_tag_ids tech_tag_ids usecase_tag_ids platform_tag_ids]
    tag_list.each do |tag_type|
      if params[tag_type].present?
        tag_filters = tag_filters + params[tag_type]
      end
    end
    @projects = Project.all
    if params[:pg_search_by_name].present?
      @projects = @projects.pg_search_by_name(params[:pg_search_by_name]).reorder(nil)
      ahoy.track "search", query: params[:pg_search_by_name]
    end
    @projects = @projects.filter_by_tag_ids(tag_filters) if tag_filters.length > 4
    @projects = @projects.where(proprietary: false) if params[:proprietary].present? &&  ActiveRecord::Type::Boolean.new.cast(params[:proprietary])
    @projects = @projects.includes([:avatar_attachment]).page params[:page]

    if turbo_frame_request?
      render partial: "pages/search_results", locals: { projects: @projects }
    else
      render "home"
    end
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
