class RenameTagTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :tags, :type, :tag_type
  end
end
