class PagesController < ApplicationController
  def home
    set_tag_options
    @projects = Project.search(params)
    track_search_query(params)
    @projects_stats = {open_source: Project.where(proprietary: false).count,
                       proprietary: Project.where(proprietary: true).count}
    top_license_tags = Tag.joins(:taggings).where(tag_type: "license")
      .group("tags.id")
      .order("COUNT(taggings.id) DESC")
      .limit(11)
      .select("tags.name, COUNT(taggings.id) AS taggings_count")
      .map(&:name)
    @top_licenses = License.where(key: top_license_tags)
    if turbo_frame_request?
      render partial: "pages/search_results", locals: {projects: @projects}
    else
      render "home"
    end
  end

  def static
    @static_page = StaticPage.find_by(key: params[:key])
    return unless @static_page.nil?

    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    nil
  end

  def subscribed
  end
end
