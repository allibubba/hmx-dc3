class UpdateVideoTable < ActiveRecord::Migration
  def up
    remove_column :videos, :panda_video_id
    add_column :videos, :video_id, :integer
  end

  def down
    add_column :videos, :viddler_id, :panda_video_id
  end
end
