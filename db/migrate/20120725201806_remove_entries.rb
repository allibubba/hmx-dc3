class RemoveEntries < ActiveRecord::Migration
  def up
    drop_table :entries
    remove_column :videos, :entry_id
    remove_column :votes, :entry_id
  end

  def down
    create_table :entries do |t|
      t.integer :video_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
    add_column :videos, :entry_id, :integer
    add_column :votes, :entry_id, :integer
  end
end

