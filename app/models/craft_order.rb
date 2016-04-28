class CraftOrder < ActiveRecord::Base
	belongs_to :craft, :inverse_of => :craft_orders
	belongs_to :order , :inverse_of => :craft_orders

	accepts_nested_attributes_for :craft, :reject_if => lambda { |a| a[:quantity].blank?}
end
