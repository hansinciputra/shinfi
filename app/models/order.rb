class Order < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user
	has_many :order_status
	has_many :inventory_orders, :inverse_of => :order, :dependent => :destroy
	has_many :inventories, through: :inventory_orders

	accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}, :allow_destroy => true
	#accepts_nested_attributes_for :customers
	def generate_unique_id(id)
		self.url_id = "#{id}s#{SecureRandom.hex(3)}" 
		save
	end
	def self.number_of_new_order(status)
		Order.where(:readyorpo => "#{status}").where(:order_status_id => 1)
	end
	def self.top_customers
		Customer.find_by_sql("select customers.name , 
								sum (orders.payment) from customers join orders on customers.id = orders.customer_id group by customers.name order by sum DESC NULLS LAST LIMIT 10;");
	end
	def self.top_members
		User.find_by_sql("select users.name , 
							sum (orders.payment) from users join orders on users.id = orders.user_id group by users.name order by sum DESC NULLS LAST LIMIT 10;
							");	
	end
	def self.best_seller_product
		Inventory.find_by_sql("select inventories.name, sum(inventory_orders.quantity) from inventories join inventory_orders on inventories.id = inventory_orders.inventory_id group by inventories.name order by sum DESC NULLS LAST LIMIT 10;");

	end
end
