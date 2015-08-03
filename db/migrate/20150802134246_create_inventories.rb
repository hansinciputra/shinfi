class CreateInventories < ActiveRecord::Migration
  attr_accessible :pName, :pQuantity, :pMeter, :pWeight, :pSellPrice, :pCategory, :pPic
  def change
    create_table :inventories do |t|
      t.string :pName
      t.integer :pQuantity
      t.string :pMeter
      t.decimal :pWeight, :precision => 6, :scale => 4
      t.decimal :pSellPrice, :precision => 10, :scale => 2
      t.string :pCategory
      t.binary :pPic

      t.timestamps
    end
  end
end
