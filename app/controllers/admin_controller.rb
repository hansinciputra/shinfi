class AdminController < ApplicationController
	before_filter :authorize
	before_filter :authorize_admin
	def index
		@new_order = Order.number_of_new_order('STOCKED').count
		@new_po_order = Order.number_of_new_order('PO').count
	end
end