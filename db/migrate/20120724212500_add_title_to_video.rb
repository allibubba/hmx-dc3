class AddTitleToVideo < ActiveRecord::Migration
  def up
    add_column :videos, :title, :string
  end
  def down
    remove_column :videos, :title
  end
end
