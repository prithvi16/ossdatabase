class MakeTaggingsUniq < ActiveRecord::Migration[6.0]
  def change
    add_index :taggings, [:tag_id, :project_id], unique: true
  end
end
