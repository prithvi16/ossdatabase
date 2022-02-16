class AddTagLineToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :tag_line, :string, null: false, default: ""
  end
end
