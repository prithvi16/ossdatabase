class AddVisibleToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :visible, :boolean
  end
end
