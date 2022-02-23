class AddLogoUrlFieldToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :logo_url, :string
  end
end
