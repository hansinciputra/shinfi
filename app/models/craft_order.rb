class CraftOrder < ActiveRecord::Base
	belongs_to :craft, :inverse_of => :craft_orders
	belongs_to :order , :inverse_of => :craft_orders
end
