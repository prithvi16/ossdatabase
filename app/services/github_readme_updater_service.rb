class GithubReadmeUpdaterService
  def initialize(project_id)
    @project = Project.find(project_id)
  end

  def update_readme
    return if @project.blank? || @project.source != "github" || @project.source_id.blank?
    parsed_github_data = GithubDataFetcherService.new(@project.source_id).fetch_data

    raw_project_readme = GithubApi.client.readme @project.source_id, accept: "application/vnd.github.html"
    processed_readme = GithubReadmeFixerService.new(raw_project_readme, parsed_github_data.blob_url).perform
    @project.update!(description: processed_readme)
  end
end
