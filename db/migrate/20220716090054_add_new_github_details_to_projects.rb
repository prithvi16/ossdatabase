class AddNewGithubDetailsToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :github_forks_count, :integer
    add_column :projects, :github_watchers_count, :integer
    add_column :projects, :github_closed_issues_count, :integer
    add_column :projects, :github_total_releases_count, :integer
    add_column :projects, :github_open_pull_requests_count, :integer
    add_column :projects, :github_closed_pull_requests_count, :integer
    add_column :projects, :github_commits_count, :integer
  end
end
