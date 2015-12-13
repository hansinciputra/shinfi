class AddImgCarrierwaveToInventory < ActiveRecord::Migration
  def change
  	add_column :inventories, :prod_img, :string
  end
end
