class ProductImage < ActiveRecord::Base
	belongs_to :inventory
	mount_uploader :prod_img, ProdImgUploader

	def self.getAllProduct
		ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.brand_id,inventories.fabrictype,inventories.quantity,inventories.satuan,inventories.sellprice').where(:displaypic => 1).where("inventories.quantity > ?", 0)
	end
end
