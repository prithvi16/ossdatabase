class SiteAdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_admin

  def home
    @submissions = Submission.all
    @tag_options = TOP_TAG_TYPES.map { |tag_type| [tag_type, Tag.where(tag_type: tag_type).map { |tag| [tag.name, tag.id] }] }
  end

  def github_projects
    github_projects = params[:github_projects]
    tag_ids = params[:tag_ids]
    if params[:bulk_import].present? && params[:bulk_import] == "1"
      counter = 0
      params[:github_projects].split(/[\r\n]+/).each do |project_string|
        counter += 1
        project_params = {project_github_string: project_string, tag_ids: tag_ids}
        GithubToProjectWorker.perform_in(counter.seconds, project_params)
      end
    else
      project_params = {project_github_string: github_projects, tag_ids: tag_ids}
      GithubToProjectWorker.perform_async(project_params)
    end
    redirect_to admin_dashboard_path, flash: {notice: "Added to queue sucessfully"}
  end

  def tags
    @tag = Tag.new(name: params[:name], tag_type: params[:tag_type])
    if @tag.save
      redirect_to admin_dashboard_path, flash: {notice: "Tag created  sucessfully"}
    else
      redirect_to admin_dashboard_path, flash: {alert: "Issues: #{@tag.errors.full_messages}"}
    end
  end
end
