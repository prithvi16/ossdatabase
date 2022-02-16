class AddValidationsForProjects < ActiveRecord::Migration[6.0]
  def change
    change_column_null :projects, :name, false
    change_column_null :projects, :description, false
    change_column_null :projects, :website, false
  end
end
