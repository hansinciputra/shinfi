class AddUuiDtoOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :url_id, :string
  end
end
