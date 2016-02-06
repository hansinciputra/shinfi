class Order < ActiveRecord::Base
	belongs_to :customer
	has_many :order_status
	has_many :inventory_orders, :inverse_of => :order, :dependent => :destroy
	has_many :inventories, through: :inventory_orders
	validates :customer_id, :presence => true

	accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}, :allow_destroy => true
	#accepts_nested_attributes_for :customers
	def generate_unique_id(id)
		self.url_id = "#{id}s#{SecureRandom.hex(3)}" 
		save
	end
	def self.number_of_new_order(status)
		Order.where(:readyorpo => "#{status}").where(:order_status_id => 1)
	end
	def self.top_customers(status)
		Customer.joins(:orders).joins(:inventory_orders).joins(:inventories).select('orders.id,orders.payment,customers.name,,inventories.nameinventory_orders.quantity')
		
		Order.find_by_sql
		('
			SELECT customers.name,orders.id, SUM(orders.payment) FROM orders LEFT JOIN customers on orders.customer_id = customers.id GROUP BY customers
		')
	end
end
