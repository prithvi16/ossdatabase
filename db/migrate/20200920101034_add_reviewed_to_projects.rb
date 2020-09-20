class AddReviewedToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :reviewed, :boolean, default: false, null: false
  end
end
