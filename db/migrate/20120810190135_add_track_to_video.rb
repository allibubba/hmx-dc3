class AddTrackToVideo < ActiveRecord::Migration
  def up
    add_column :videos, :track_id, :integer
  end
  def down
    remove_column :videos, :track_id
  end
end