class AddWinnersToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :winner, :integer, :default => 0
  end
  def down
    remove_column :videos, :winner
  end
end