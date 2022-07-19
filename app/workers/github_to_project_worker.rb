class GithubToProjectWorker
  include Sidekiq::Worker

  def perform(project_github_string)
    parsed_github_data = GithubDataFetcherService.new(project_github_string).fetch_data

    project = if !Project.where(source: "github", github_id: parsed_github_data.database_id).exists?
      raw_project_readme = GithubApi.client.readme project_github_string, accept: "application/vnd.github.html"
      processed_readme = GithubReadmeFixerService.new(raw_project_readme, parsed_github_data.blob_url).perform
      Project.create!(
        name: parsed_github_data.name,
        website: parsed_github_data.html_url,
        tag_line: parsed_github_data.description,
        description: processed_readme,
        visible: true,
        reviewed: true,
        source: "github",
        github_id: parsed_github_data.database_id,
        source_id: project_github_string,
        last_updated_from_source: DateTime.now,
        repo_url: parsed_github_data.html_url
      )
    else
      Project.where(source: "github", github_id: parsed_github_data.database_id).first
    end
    GithubSyncWorker.perform_async(project.id.to_i)
  end
end
