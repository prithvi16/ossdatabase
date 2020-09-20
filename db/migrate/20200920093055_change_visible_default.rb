class ChangeVisibleDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_null :projects, :visible, false
    change_column_default :projects, :visible, true
  end
end
