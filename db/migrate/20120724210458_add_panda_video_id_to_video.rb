class AddPandaVideoIdToVideo < ActiveRecord::Migration
  def up
    add_column :videos, :panda_video_id, :string
  end
  def down
    remove_column :videos, :panda_video_id
  end
end
