class AddDescriptionToLicense < ActiveRecord::Migration[6.1]
  def change
    add_column :licenses, :description, :text
  end
end
