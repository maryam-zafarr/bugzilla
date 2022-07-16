class AddIndexToProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :projects_users, :user_id
    add_index :projects_users, :project_id
  end
end
