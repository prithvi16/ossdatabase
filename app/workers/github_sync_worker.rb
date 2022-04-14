class GithubSyncWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    github_client = Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
    if project.github_id.present?
      github_repo_data = github_client.repo project.github_id
      github_commits_data = github_client.commits project.github_id
    else
      github_repo_data = github_client.repo project.source_id
      github_commits_data = github_client.commits project.source_id
    end
    project.update!(github_open_issues_count: github_repo_data.open_issues_count, 
                    github_last_commit_date: github_commits_data.first.commit.committer.date,
                    github_stars: github_repo_data.stargazers_count, 
                    github_id: github_repo_data.id, 
                    source_id: github_repo_data.full_name, 
                    repo_url: github_repo_data.html_url, 
                    last_updated_from_source: DateTime.now)
    github_release_data = github_client.releases project.github_id
    if github_release_data.length > 0
      project.update!(github_last_release_date: github_release_data.first.published_at)
    end
  end
end