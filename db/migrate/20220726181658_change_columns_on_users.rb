class ChangeColumnsOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :user_type, false
  end
end
