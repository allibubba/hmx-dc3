class AddEntryIdToVideo < ActiveRecord::Migration
  def up
    add_column :videos, :entry_id, :integer
  end
  def down
    remove_column :videos, :entry_id
  end
end
