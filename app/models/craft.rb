class Craft < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]
	
	has_many :craft_orders, :inverse_of => :craft
	has_many :orders , :through => :craft_orders
	has_many :price_dets
	has_many :product_images, dependent: :destroy #if craft is removed, the picture also removed
	belongs_to :brand
	belongs_to :user
	validates_uniqueness_of :name, :message => "Nama Sudah Terpakai, bisakah mengunakan nama lain?"
	

	accepts_nested_attributes_for :price_dets, allow_destroy: true , :reject_if => lambda { |a| a[:subject].blank?}
	accepts_nested_attributes_for :product_images, :allow_destroy => true #allow destroy of child in parent form

	scope :get_craft, ->{
			select("crafts.name,crafts.id,price_dets_temp.craft_id, crafts.category,crafts.subcategory,crafts.slug,crafts.user_id,crafts.brand_id,price_dets_temp.subject,price_dets_temp.pd_price_row,price_dets_temp.price,product_images.prod_img,product_images.displaypic,product_images.craft_id").joins("INNER JOIN (SELECT price_dets.craft_id,price_dets.subject,price_dets.price,row_number() over(partition by price_dets.craft_id )as pd_price_row from price_dets 
	                GROUP BY price_dets.craft_id,price_dets.subject,price_dets.price)price_dets_temp ON crafts.id = price_dets_temp.craft_id 
	                AND price_dets_temp.pd_price_row = 1 ").joins(:product_images).merge(ProductImage.get_displaypicture)
		}
	scope :brand, ->(brand){where('brand_id = ?',brand)}	
	scope :category,->(category){where('category = ?',category)}
	scope :minprice, ->(min){where('price >= ?',min)}
	scope :maxprice, ->(max){where('price <= ?',max)}
end
