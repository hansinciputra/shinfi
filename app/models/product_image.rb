class ProductImage < ActiveRecord::Base
	belongs_to :inventory
	belongs_to :craft
	mount_uploader :prod_img, ProdImgUploader

	def self.getAllProduct
		ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.brand_id,inventories.fabrictype,inventories.quantity,inventories.satuan,inventories.sellprice').where(:displaypic => 1).where("inventories.quantity > ?", 0)
	end

	#tipe 1 for fabrics or inventory table
	#tipe 2 for crafts
	def self.setDisplayPic(id,product_id,tipe)
		#get all picture of the specified product id
		if tipe == 2
			@prod_pictures = ProductImage.where(:craft_id => product_id)
		else	
			@prod_pictures = ProductImage.where(:inventory_id => product_id)
		end
		#set all picture display pic to 0, unset all previously choosen display pic
		@prod_pictures.each do |t|
			t.update_attribute(:displaypic,nil)
		end
		#get the selected product image wanted to be the display pic
		@product_images = ProductImage.find(id)
		#in model need to use sql command to CRUD attributes
		@product_images.update_attribute(:displaypic,1)
			
	end
end
