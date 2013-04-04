class AddVideoIdToVotes < ActiveRecord::Migration
  def up
    add_column :votes, :video_id, :integer
  end
  def down
    remove_column :votes, :video_id
  end
end
