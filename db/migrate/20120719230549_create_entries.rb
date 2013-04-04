class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :video_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
