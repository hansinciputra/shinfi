class CreateOrdersAndInventories < ActiveRecord::Migration
  def change
    create_table :inventory_orders, id: false do |t|
    	t.belongs_to :orders
    	t.belongs_to :inventories
    end

    add_index :inventory_orders, :orders_id
    add_index :inventory_orders, :inventories_id
  end
end
