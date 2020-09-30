class CreateStaticPages < ActiveRecord::Migration[6.0]
  def change
    create_table :static_pages do |t|
      t.string :key
      t.text :content

      t.timestamps
    end
  end
end
