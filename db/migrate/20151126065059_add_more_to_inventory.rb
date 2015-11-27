class AddMoreToInventory < ActiveRecord::Migration
  def change
  	add_column :inventories, :material, :string
  	add_column :inventories, :type, :string
  	add_column :inventories, :link, :string
  end
end
