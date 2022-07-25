class AddReporterToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :reporter
  end
end
