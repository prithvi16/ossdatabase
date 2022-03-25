class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :submissions do |t|
      t.string :name
      t.string :tagline
      t.text :description
      t.string :alternative_to
      t.string :website
      t.string :suggested_tags

      t.timestamps
    end
  end
end
