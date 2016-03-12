class AddBrandIdtoInventory < ActiveRecord::Migration
  def change
  	add_column :inventories, :brand_id ,:integer
  end
end
