class ChangeVideoTitleToType < ActiveRecord::Migration
  def up
    rename_column :videos, :title, :video_type
  end

  def down
    rename_column :videos, :video_type, :title
  end
end
