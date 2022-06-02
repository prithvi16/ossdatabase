class AddDetailsToSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_column :submissions, :proprietary, :boolean, default: false
    add_column :submissions, :premium, :boolean, default: false
    add_column :submissions, :github_url, :string
    add_column :submissions, :logo_url, :string
  end
end
