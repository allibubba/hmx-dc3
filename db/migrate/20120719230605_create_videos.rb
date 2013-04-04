class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :cdn_resource

      t.timestamps
    end
  end
end
