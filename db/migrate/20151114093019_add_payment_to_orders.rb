class AddPaymentToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :payment, :decimal, precision: 10, scale: 2
  end
end
