class AddYoutubeLinkToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :youtube_url, :string
  end

  def down
    remove_column :videos, :youtube_url
  end
end
