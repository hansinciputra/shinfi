class Order < ActiveRecord::Base

	belongs_to :customer
	has_many :inventory_orders, :inverse_of => :order, :dependent => :destroy
	has_many :inventories, through: :inventory_orders
	validates :customer_id, :presence => true

	accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}, :allow_destroy => true
	#accepts_nested_attributes_for :customers

end
