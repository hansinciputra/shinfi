class Order < ActiveRecord::Base
	belongs_to :customer
	has_many :inventory_orders
	has_many :inventories, through: :inventory_orders
	validates :customer_id, :presence => true
end
