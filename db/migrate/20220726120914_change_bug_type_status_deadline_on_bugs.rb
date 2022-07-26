class ChangeBugTypeStatusDeadlineOnBugs < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bugs, :bug_type, false
    change_column_null :bugs, :status, false
    change_column_null :bugs, :deadline, false
  end
end
