class AddRepoUrlToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :repo_url, :string
  end
end
