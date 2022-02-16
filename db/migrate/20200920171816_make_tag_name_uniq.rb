class MakeTagNameUniq < ActiveRecord::Migration[6.0]
  def change
    add_index :tags, :name, unique: true
    change_column_null :tags, :name, false
    add_column :tags, :type, :string
    add_column :tags, :top_category, :boolean, default: false, null: false
  end
end
