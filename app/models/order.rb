class Order < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user
	belongs_to :order_status
	#many to many relations with inventory
	has_many :inventory_orders, :inverse_of => :order, :dependent => :destroy
	has_many :inventories, through: :inventory_orders
	#many to many relations with craft
	has_many :craft_orders, :inverse_of => :order, :dependent => :destroy
	has_many :crafts, through: :craft_orders

	accepts_nested_attributes_for :inventory_orders, :reject_if => lambda { |a| a[:quantity].blank?}, :allow_destroy => true
	accepts_nested_attributes_for :craft_orders, :reject_if => lambda { |a| a[:quantity].blank?}, :allow_destroy => true

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
	def self.best_seller_product_pic
		inventory_id = Inventory.find_by_sql("select inventories.id, sum(inventory_orders.quantity) from inventories join inventory_orders on inventories.id = inventory_orders.inventory_id group by inventories.id order by sum DESC NULLS LAST LIMIT 10;");
		product_image = []
		inventory_id.each do |id|
			temp = ProductImage.find_by :inventory_id => id
			product_image << temp
		end
		return product_image
	end
	def self.total_user_spending(params)
		Order.find_by_sql("SELECT orders.url_id,orders.user_id, inventory_orders.quantity,inventories.sellprice FROM orders LEFT JOIN inventory_orders ON orders.id = inventory_orders.order_id LEFT JOIN inventories ON inventory_orders.inventory_id = inventories.id WHERE orders.user_id = '#{params}'
		;");
	end
end
