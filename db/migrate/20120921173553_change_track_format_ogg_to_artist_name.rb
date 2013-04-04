class ChangeTrackFormatOggToArtistName < ActiveRecord::Migration
  def up
    rename_column :tracks, :format_ogg, :artist_name
  end

  def down
    rename_column :tracks, :artist_name, :format_ogg
  end
end
