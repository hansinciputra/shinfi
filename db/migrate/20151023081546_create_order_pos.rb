class CreateOrderPos < ActiveRecord::Migration
  def change
    create_table :order_pos do |t|
    	
      t.timestamps
    end
  end
end
