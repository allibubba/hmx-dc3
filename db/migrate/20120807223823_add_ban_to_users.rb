class AddBanToUsers < ActiveRecord::Migration
  def up
    add_column :users, :banned, :boolean, :default => 0
  end
  def down
    remove_column :users, :banned
  end
end