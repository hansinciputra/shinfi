class ReportController < ApplicationController
	before_filter :authorize
	before_filter :authorize_admin
	def index
		@top_user_purchase = User.find_by_sql("select users.name , 
							sum (orders.payment) from users join orders on users.id = orders.user_id group by users.name order by sum DESC NULLS LAST LIMIT 10;
							");
		@top_guest_purchase = Customer.find_by_sql("select customers.name , 
								sum (orders.payment) from customers join orders on customers.id = orders.customer_id group by customers.name order by sum DESC NULLS LAST LIMIT 10;");
		@top_product_sold = Inventory.find_by_sql("select inventories.name, sum(inventory_orders.quantity) from inventories join inventory_orders on inventories.id = inventory_orders.inventory_id group by inventories.name order by sum DESC NULLS LAST LIMIT 10;");
	end
end