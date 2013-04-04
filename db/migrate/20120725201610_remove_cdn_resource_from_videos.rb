class RemoveCdnResourceFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :cdn_resource
  end
  def down
    add_column :videos, :cdn_resource, :string
  end
end