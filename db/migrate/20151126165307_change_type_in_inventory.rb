class ChangeTypeInInventory < ActiveRecord::Migration
  def change
  	remove_column :inventories, :type
  	add_column :inventories, :fabrictype, :string
  end
end
