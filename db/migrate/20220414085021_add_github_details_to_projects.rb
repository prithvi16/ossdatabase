class AddGithubDetailsToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :github_last_release_date, :datetime
    add_column :projects, :github_last_commit_date, :datetime
    add_column :projects, :github_open_issues_count, :bigint
  end
end
