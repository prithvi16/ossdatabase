class AddSourceToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :source, :string
    add_column :projects, :source_id, :string
    add_column :projects, :last_updated_from_source, :datetime
  end
end
