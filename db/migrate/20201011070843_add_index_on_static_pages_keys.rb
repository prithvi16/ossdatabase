class AddIndexOnStaticPagesKeys < ActiveRecord::Migration[6.0]
  def change
    add_index :static_pages, :key, unique: true
  end
end
