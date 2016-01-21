class CartController < ApplicationController
  def index
  	if session[:cart]
  		cart = session[:cart]

  		@cart_items = []
  		#keys karena cart session menampung 2 data :key => :values
  		cart.keys.each do |x|
  			product = Inventory.find(x)
  			if product
  				#this is how we populte the cart_item array with each result of the find method
  				@cart_items << product
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
  		cart[product_id] = cart[product_id]+1
  	else
  		cart[product_id] = 1
  	end
  	redirect_to :action => :index
  end

  def clear
  	id = params[:id]
  	session[:cart].delete id
  	redirect_to :action => :index
  end
end
