class FixInventoryTableName < ActiveRecord::Migration
  def change
  	rename_column :inventories, :pName , :name
  	rename_column :inventories, :pQuantity , :quantity
  	rename_column :inventories, :pMeter , :meter
  	rename_column :inventories, :pWeight , :weight
  	rename_column :inventories, :pSellPrice , :sellprice
  	rename_column :inventories, :pCategory , :category
  	rename_column :inventories, :pPic , :pic
  end
end
