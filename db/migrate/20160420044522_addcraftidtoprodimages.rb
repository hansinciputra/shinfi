class Addcraftidtoprodimages < ActiveRecord::Migration
  def change
  	add_column :product_images,:craft_id, :integer
  end
end
