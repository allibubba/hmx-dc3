class AddTitleToTracks < ActiveRecord::Migration
  def up
    add_column :tracks, :title, :string
  end
  def down
    remove_column :tracks, :title
  end
end