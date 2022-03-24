class GithubSyncWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    github_client = Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
    github_repo_data = github_client.repo project.source_id
    project.update!(github_stars: github_repo_data.stargazers_count, repo_url: github_repo_data.html_url, last_updated_from_source: DateTime.now)
  end
end