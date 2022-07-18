class GithubToProjectWorker
  include Sidekiq::Worker

  def perform(project_github_string)
    github_client = Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
    github_repo_data = github_client.repo project_github_string
    project_readme = github_client.readme project_github_string, accept: "application/vnd.github.html"
    project = if !Project.where(source: "github", github_id: github_repo_data.id).exists?
      Project.create!(
        name: github_repo_data.name,
        website: github_repo_data.html_url,
        tag_line: github_repo_data.description,
        description: project_readme,
        visible: true,
        reviewed: true,
        source: "github",
        source_id: github_repo_data.id,
        last_updated_from_source: DateTime.now,
        repo_url: github_repo_data.html_url
      )
    else
      Project.where(source: "github", github_id: github_repo_data.id).first
    end
    GithubSyncWorker.perform_async(project.id)
  end
end
