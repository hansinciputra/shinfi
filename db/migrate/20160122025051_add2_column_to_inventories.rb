class Add2ColumnToInventories < ActiveRecord::Migration
  def change
  	add_column :inventories, :satuan, :string
  	add_column :inventories, :ukuran, :string
  	add_column :inventories, :berat, :string
  	add_column :inventories, :warna, :string
  end
end
