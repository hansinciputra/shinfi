class InventoryOrder < ActiveRecord::Base
	
	belongs_to :inventory , :inverse_of => :inventory_orders
	belongs_to :order , :inverse_of => :inventory_orders

	#has_many :inventories
	validates :quantity, :presence => true

	accepts_nested_attributes_for :inventory, :reject_if => lambda { |a| a[:quantity].blank?}
		
end