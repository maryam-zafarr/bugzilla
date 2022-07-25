class AddAssigneeToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :assignee
  end
end
