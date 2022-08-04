class PagesController < ApplicationController
  def home
    set_tag_options
    @projects = Project.search(params)
    track_search_query(params)
    @projects_stats = {open_source: Project.where(proprietary: false).count, proprietary: Project.where(proprietary: true).count}
    @license_data = Project.joins(:tags).where("tags.tag_type = 'license'").group("tags.name").count
    if turbo_frame_request?
      render partial: "pages/search_results", locals: {projects: @projects}
    else
      render "home"
    end
  end

  def static
    @static_page = StaticPage.find_by(key: params[:key])
    if @static_page.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      nil
    end
  end

  def subscribed
  end
end
