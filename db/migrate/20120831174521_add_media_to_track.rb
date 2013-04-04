class AddMediaToTrack < ActiveRecord::Migration
  def up
    add_column :tracks, :media, :string
  end
  def down
    remove_column :media, :string
  end
end