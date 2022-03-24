class GithubSyncWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    github_client = Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
    if project.github_id.present?
      github_repo_data = github_client.repo project.github_id
    else
      github_repo_data = github_client.repo project.source_id
    end
    project.update!(github_stars: github_repo_data.stargazers_count, github_id: github_repo_data.id, source_id: github_repo_data.full_name, repo_url: github_repo_data.html_url, last_updated_from_source: DateTime.now)
  end
end