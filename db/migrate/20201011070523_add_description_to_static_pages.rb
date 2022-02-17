class AddDescriptionToStaticPages < ActiveRecord::Migration[6.0]
  def change
    add_column :static_pages, :description, :text, null: false, default: ""
  end
end
