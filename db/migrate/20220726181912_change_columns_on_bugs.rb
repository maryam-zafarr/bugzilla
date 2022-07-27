class ChangeColumnsOnBugs < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bugs, :title, false
    change_column_null :bugs, :reporter_id, false
    change_column_null :bugs, :project_id, false
  end
end
