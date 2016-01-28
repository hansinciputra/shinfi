class CartController < ApplicationController
  def index
  	#to prevent user from inserting another new customer on head menu
  	data_customer = Customer.where(:user_id => session[:user_id])
      data_customer.each do |data|
        session[:customer_id] = data.user_id
    end
  	if session[:cart]
  		cart = session[:cart]

  		@total = []	
  		cart.each do |key , value|
		sellprice = Inventory.select("id,sellprice").where(:id => key)
			sellprice.each do |t|
			sum = value.to_i * t.sellprice
			@total << sum
			end
		end
  	else
  		@cart = {}
  	end
  end

  def add
  	product_id ||= params[:id]

  	if session[:cart] 
  		cart = session[:cart]
  	else
  		session[:cart] = {}
  		cart = session[:cart]
  	end
  	if cart[product_id]
  		#this line is really not important, will delete later..
  		cart[product_id] = cart[product_id]
  	else
  		cart[product_id] = 1
  	end
  	redirect_to :action => :index
  end

  def addquantity
  new_quantity = params[:quantity] 
  product_id = params[:product_id]

	cart = session[:cart]
	#index disini sebagai penunjuk urutan array dari new_quantity
	product_id.each_with_index do |key,index|
		cart[key] = new_quantity[index]
	end  
  	redirect_to :action => :index
  end

  def checkout
  	if session[:cart]
  		cart = session[:cart]

  		@total = []	
  		cart.each do |key , value|
		sellprice = Inventory.select("id,sellprice").where(:id => key)
			sellprice.each do |t|
			sum = value.to_i * t.sellprice
			@total << sum
			end
		end
  	else
  		@cart = {}
  	end
  	@customer_id = params[:customer_id]
  	@customer = Customer.find(params[:customer_id])
  	@order = Order.new
  	@inventory_order = @order.inventory_orders.build
  end

  def checkout_po
  	if session[:cart]
  		cart = session[:cart]

  		@total = []	
  		cart.each do |key , value|
		sellprice = Inventory.select("id,sellprice").where(:id => key)
			sellprice.each do |t|
			sum = value.to_i * t.sellprice
			@total << sum
			end
		end
  	else
  		@cart = {}
  	end
  	@customer_id = params[:customer_id]
  	@customer = Customer.find(params[:customer_id])
  	@order = Order.new
  	@inventory_order = @order.inventory_orders.build
  end
  def clear
  	id = params[:id]
  	session[:cart].delete id
  	if session[:cart] == {}
  		session[:cart] = nil
  	end
  	redirect_to :action => :index
  end
end
