class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :website
      t.string :description
      t.date :first_release
      t.date :last_release
      t.boolean :premium

      t.timestamps
    end
  end
end
