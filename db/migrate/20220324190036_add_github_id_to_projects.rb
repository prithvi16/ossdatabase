class AddGithubIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :github_id, :bigint
  end
end
