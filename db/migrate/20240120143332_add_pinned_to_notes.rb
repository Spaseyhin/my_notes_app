class AddPinnedToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :pinned, :boolean, default: false
  end
end
