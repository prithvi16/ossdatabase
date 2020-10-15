class AddSlugToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :slug, :string
    add_index :tags, :slug, unique: true
    Tag.find_each(&:save)
  end
end
