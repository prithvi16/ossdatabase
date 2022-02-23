class AddProprietaryField < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :proprietary, :boolean, default: false
  end
end
