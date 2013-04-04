class ChaneVideoidToMediaIdString < ActiveRecord::Migration
  def up
    remove_column :videos, :video_id
    add_column :videos, :media_id, :string
  end

  def down
    add_column :videos, :video_id, :integer
    remove_column :videos, :media_id
  end
end
