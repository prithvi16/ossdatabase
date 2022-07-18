class GithubSyncWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    github_client = Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
    github_repo_data = if project.github_id.present?
      github_client.repo project.github_id
    else
      github_client.repo project.source_id
    end
    project.update!(github_open_issues_count: github_repo_data.open_issues_count,
      github_stars: github_repo_data.stargazers_count,
      github_id: github_repo_data.id,
      source_id: github_repo_data.full_name,
      repo_url: github_repo_data.html_url,
      github_forks_count: github_repo_data.forks_count,
      github_watchers_count: github_repo_data.watchers_count,
      last_updated_from_source: DateTime.now)
    owner, name = github_repo_data.full_name.split("/")
    body = {query: REPOSITORY_DATA_QUERY, variables: {owner: owner, name: name}}
    graphql_response = github_client.post "https://api.github.com/graphql", Oj.dump(body, mode: :compat)
    parsed_github_data = GithubRepositoryDataService.new(graphql_response)
    project.update!(
      github_commits_count: parsed_github_data.total_commits,
      github_closed_issues_count: parsed_github_data.total_closed_issues,
      github_open_pull_requests_count: parsed_github_data.open_pull_requests,
      github_closed_pull_requests_count: parsed_github_data.merged_pull_requests,
      github_total_releases_count: parsed_github_data.total_releases,
      github_last_release_date: parsed_github_data.last_release_date,
      github_last_commit_date: parsed_github_data.last_commit_date
    )
  end
end
