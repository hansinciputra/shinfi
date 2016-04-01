class CreateCraftOrders < ActiveRecord::Migration
  def change
    create_table :craft_orders do |t|
      t.integer :order_id
      t.integer :craft_id
      t.decimal :quantity

      t.timestamps
    end
  end
end
