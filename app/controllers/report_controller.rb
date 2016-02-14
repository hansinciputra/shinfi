class ReportController < ApplicationController
	before_filter :authorize
	before_filter :authorize_admin
	def index
		#from order model
		@top_user_purchase = Order.top_members
		@top_guest_purchase = Order.top_customers
		@top_product_sold = Order.best_seller_product
	end
end