class AddTitleToStaticPages < ActiveRecord::Migration[6.0]
  def change
    add_column :static_pages, :title, :string
  end
end
