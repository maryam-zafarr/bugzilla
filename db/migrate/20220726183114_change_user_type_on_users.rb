class ChangeUserTypeOnUsers < ActiveRecord::Migration[5.2]
  def change
    User.where(user_type: 'Manager').update_all(user_type: 0)
    User.where(user_type: 'Developer').update_all(user_type: 1)
    User.where(user_type: 'Quality Assurance Engineer').update_all(user_type: 2)
    change_column :users, :user_type, :integer, using: 'user_type::integer'
  end
end
