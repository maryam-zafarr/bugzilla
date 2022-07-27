class ChangeBugTypeOnBugs < ActiveRecord::Migration[5.2]
  def change
    Bug.where(bug_type: 'Bug').update_all(bug_type: 0)
    Bug.where(bug_type: 'Feature').update_all(bug_type: 1)
    change_column :bugs, :bug_type, :integer, using: 'bug_type::integer'
  end
end
