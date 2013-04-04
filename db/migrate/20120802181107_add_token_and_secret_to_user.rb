class AddTokenAndSecretToUser < ActiveRecord::Migration
  def up
    add_column :users, :usersecret, :integer
    add_column :users, :usertoken, :integer
  end
  def down
    remove_column :users, :usersecret
    remove_column :users, :usertoken
  end
end
