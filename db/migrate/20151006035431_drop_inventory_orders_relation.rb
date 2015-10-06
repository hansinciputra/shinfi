class DropInventoryOrdersRelation < ActiveRecord::Migration
  def change
  	drop_table :inventory_orders
  end
end
