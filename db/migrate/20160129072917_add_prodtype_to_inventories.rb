class AddProdtypeToInventories < ActiveRecord::Migration
  def change
  	add_column :inventories, :prodtype ,:string
  end
end
