class InventoryOrder < ActiveRecord::Base
	belongs_to :inventory
	belongs_to :order

	#has_many :inventories
	validates :quantity, :presence => true
end