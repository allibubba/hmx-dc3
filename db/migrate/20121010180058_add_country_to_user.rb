class AddCountryToUser < ActiveRecord::Migration
  def up
    add_column :users, :country, :string
  end
  def down
    remove_column :users, :country
  end
end
