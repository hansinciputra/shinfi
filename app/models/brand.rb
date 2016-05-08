class Brand < ActiveRecord::Base
	mount_uploader :brand_pic , BrandImgUploader
	has_many :inventories
	has_many :crafts

	validates_uniqueness_of :name

	def self.show_brand_on_id(brand_id)
		Brand.find(brand_id)
	end
end
