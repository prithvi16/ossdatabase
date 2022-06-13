class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :name
      t.string :key
      t.text :content

      t.timestamps
    end
  end
end
