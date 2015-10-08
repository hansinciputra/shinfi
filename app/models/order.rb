class Order < ActiveRecord::Base
	belongs_to :customer
	has_many :inventory_orders
	has_many :inventories, through: :inventory_orders
	validates :customer_id, :presence => true

	accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}
	#accepts_nested_attributes_for :customers
end
