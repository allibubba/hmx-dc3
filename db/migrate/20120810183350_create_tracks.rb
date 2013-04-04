class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :format_mpeg
      t.string :format_ogg
      t.string :status
      t.timestamps
    end
  end
end
