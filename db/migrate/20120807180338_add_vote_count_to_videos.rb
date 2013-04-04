class AddVoteCountToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :votes_count, :integer
  end
  def down
    remove_column :videos, :votes_count
  end
end