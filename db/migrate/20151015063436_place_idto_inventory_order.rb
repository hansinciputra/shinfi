class PlaceIdtoInventoryOrder < ActiveRecord::Migration
  def change
  	add_column :inventory_orders, :id, :primary_key
  end
end
