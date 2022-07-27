class ChangeColumnsOnProject < ActiveRecord::Migration[5.2]
  def change
    change_column_null :projects, :title, false
    change_column_null :projects, :description, false
    change_column_null :projects, :manager_id, false
  end
end
