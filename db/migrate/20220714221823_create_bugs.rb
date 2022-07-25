class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :bug_type
      t.string :status
      t.date :deadline

      t.timestamps
    end
  end
end
