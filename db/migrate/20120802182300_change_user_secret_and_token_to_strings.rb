class ChangeUserSecretAndTokenToStrings < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :usersecret, :string
      t.change :usertoken, :string
    end
  end

  def self.down
    change_table :users do |t|
      t.change :usersecret, :integer
      t.change :usertoken, :integer
    end
  end
end