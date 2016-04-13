class Craft < ActiveRecord::Base
	has_many :craft_orders, :inverse_of => :craft
	has_many :orders , :through => :craft_orders
	has_many :price_dets
end
