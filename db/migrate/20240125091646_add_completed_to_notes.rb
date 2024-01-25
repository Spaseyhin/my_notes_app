class AddCompletedToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :completed, :boolean unless column_exists?(:notes, :completed)
  end
end
