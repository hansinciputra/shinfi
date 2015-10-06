class RemoveInsertQuantityColumn < ActiveRecord::Migration
  def change
  	remove_column :orders, :quantity
  	add_column :inventory_orders, :quantity, :integer
  end
end
