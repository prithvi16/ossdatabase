class AddGithubStarToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :github_stars, :bigint
  end
end
