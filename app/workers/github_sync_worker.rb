class GithubSyncWorker
  include Sidekiq::Worker

  def perform(project_id)
    @project = Project.find(project_id)
    github_repo_data = fetch_repo_data
    update_with_repo_data(github_repo_data)
    parsed_github_data = fetch_graphql_data
    update_with_graphql_data(parsed_github_data)
    update_readme
    attach_logo unless @project.avatar.attached?
    attach_github_license(github_repo_data) unless @project.any_tags_with?("license")
    update_project_technologies unless @project.any_tags_with?("tech")
  end

  def attach_logo
    AttachGithubProjectLogoWorker.new.perform(@project.id)
  end

  def fetch_repo_data
    if @project.github_id.present?
      GithubApi.client.repo @project.github_id
    else
      GithubApi.client.repo @project.source_id
    end
  end

  def attach_github_license(github_repo_data)
    return unless github_repo_data.license?

    @project.tag_with(github_repo_data.license.key, "license")
  end

  def update_project_technologies
    tech_data = GithubApi.client.languages @project.source_id
    tech_data.each do |tech, _|
      @project.tag_with(tech, "tech")
    end
  end

  def update_with_repo_data(github_repo_data)
    @project.update!(
      github_open_issues_count: github_repo_data.open_issues_count,
      github_stars: github_repo_data.stargazers_count,
      github_id: github_repo_data.id,
      source_id: github_repo_data.full_name,
      repo_url: github_repo_data.html_url,
      github_forks_count: github_repo_data.forks_count,
      github_watchers_count: github_repo_data.watchers_count,
      last_updated_from_source: DateTime.now
    )
  end

  def fetch_graphql_data
    GithubDataFetcherService.new(@project.source_id).fetch_data
  end

  def update_with_graphql_data(parsed_github_data)
    @project.update!(
      github_commits_count: parsed_github_data.total_commits,
      github_closed_issues_count: parsed_github_data.total_closed_issues,
      github_open_pull_requests_count: parsed_github_data.open_pull_requests,
      github_closed_pull_requests_count: parsed_github_data.merged_pull_requests,
      github_total_releases_count: parsed_github_data.total_releases,
      github_last_release_date: parsed_github_data.last_release_date,
      github_last_commit_date: parsed_github_data.last_commit_date
    )
  end

  def update_readme
    GithubReadmeUpdaterService.new(@project.id).update_readme
  end
end
