class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :entry_id
      t.integer :user_id

      t.timestamps
    end
  end
end
