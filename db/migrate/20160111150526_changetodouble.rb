class Changetodouble < ActiveRecord::Migration
  def change
  	change_column :inventory_orders, :quantity, :decimal
  	change_column :inventories, :quantity, :decimal
  end
end
