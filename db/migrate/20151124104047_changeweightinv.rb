class Changeweightinv < ActiveRecord::Migration
  def change
  	remove_column :inventories, :weight
  	add_column :inventories, :weight, :decimal, precision: 10, scale: 2
  end
end
