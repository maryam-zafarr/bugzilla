class ChangeForeignKeyForProjects < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :user_id, :manager_id
  end
end
