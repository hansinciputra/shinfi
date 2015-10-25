class AddTypeToOrders < ActiveRecord::Migration
  def change
  	add_column :orders , :readyorpo , :string
  end
end
