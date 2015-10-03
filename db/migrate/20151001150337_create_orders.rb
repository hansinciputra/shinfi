class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.decimal :total_price, :precision => 10, :scale => 2
    	t.belongs_to :customer
    	t.datetime :order_date
      t.timestamps
    end

    add_index :orders, :customers_id
  end
end
