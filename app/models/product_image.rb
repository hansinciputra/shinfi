class ProductImage < ActiveRecord::Base
	belongs_to :inventory
	mount_uploader :prod_img, ProdImgUploader
end
