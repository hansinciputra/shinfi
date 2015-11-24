class AddOngkirToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :ongkir, :decimal , precision: 10, scale: 2
  	add_column :orders, :discount, :decimal, precision: 10, scale: 2
  end
end
