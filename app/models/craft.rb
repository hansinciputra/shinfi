class Craft < ActiveRecord::Base
	has_many :craft_orders, :inverse_of => :craft
	has_many :orders , :through => :craft_orders
	has_many :price_dets
	has_many :product_images, dependent: :destroy #if craft is removed, the picture also removed
	validates_uniqueness_of :name, :message => "Nama Sudah Terpakai, bisakah mengunakan nama lain?"

	accepts_nested_attributes_for :price_dets, allow_destroy: true , :reject_if => lambda { |a| a[:subject].blank?}
	accepts_nested_attributes_for :product_images, :allow_destroy => true #allow destroy of child in parent form

end
