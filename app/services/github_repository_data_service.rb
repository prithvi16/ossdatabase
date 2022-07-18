class GithubRepositoryDataService
  attr_accessor :raw_data

  def initialize(raw_data)
    self.raw_data = raw_data.dig(:data, :repository)
  end

  def total_commits
    raw_data.dig(:defaultBranchRef, :target, :history, :totalCount)
  end

  def total_closed_issues
    raw_data.dig(:closedIssues, :totalCount)
  end

  def open_pull_requests
    raw_data.dig(:openPullRequests, :totalCount)
  end

  def merged_pull_requests
    raw_data.dig(:mergedPullRequests, :totalCount)
  end

  def total_releases
    raw_data.dig(:releases, :totalCount)
  end

  def default_branch_name
    raw_data.dig(:defaultBranchRef, :name)
  end

  def html_url
    raw_data.dig(:url)
  end

  def blob_url
    html_url + "/blob/" + default_branch_name
  end

  def name
    raw_data.dig(:name)
  end

  def description
    raw_data.dig(:description)
  end

  def database_id
    raw_data.dig(:databaseId)
  end

  def last_release_date
    if total_releases > 0
      raw_data.dig(:latestRelease, :publishedAt)
    end
  end

  def last_commit_date
    raw_data.dig(:defaultBranchRef, :target, :history, :edges, 0, :node, :committedDate)
  end

  def primary_language
    raw_data.dig(:primaryLanguage, :name)
  end

  def license
    raw_data.dig(:licenseInfo, :key)
  end
end
