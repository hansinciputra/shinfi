class FixIndexForeignKey < ActiveRecord::Migration
  def change
    create_table :inventory_orders, id: false do |t|
    	t.belongs_to :order
    	t.belongs_to :inventory
    end

    add_index :inventory_orders, :order_id
    add_index :inventory_orders, :inventory_id
  end
end
