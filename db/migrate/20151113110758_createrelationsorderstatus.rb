class Createrelationsorderstatus < ActiveRecord::Migration
  def change
  	remove_column :orders, :status
  	add_column :orders, :order_status_id, :integer
  end
end
