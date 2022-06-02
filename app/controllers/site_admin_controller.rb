class SiteAdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_admin

  def home
    @submissions = Submission.all
  end

  def github_projects
    github_projects = params[:github_projects]
    GithubToProjectWorker.perform_async(github_projects)
    redirect_to site_admin_home_path, flash: {notice: "Added to queue sucessfully"}
  end

  def tags
    @tag = Tag.new(name: params[:name], tag_type: params[:tag_type])
    if @tag.save
      redirect_to site_admin_home_path, flash: {notice: "Tag created  sucessfully"}
    else
      redirect_to site_admin_home_path, flash: {alert: "Issues: #{@tag.errors.full_messages}"}
    end
  end
end
