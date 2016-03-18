class CartController < ApplicationController
  def index
    #to check whether user has input personal detail
  	@data_user = User.find_by(:id => session[:user_id])
    if @data_user
      #we store session phone so we can be sure that user has already insert the data, we check it on cart index page
      session[:phone] = @data_user.phone
    end
    if session[:cust_notes]
      @cust_notes = session[:cust_notes]
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

  def index_po
    #to check whether user has input personal detail
    @data_user = User.find_by(:id => session[:user_id])
    if @data_user
      #we store session phone so we can be sure that user has already insert the data, we check it on cart index page
      session[:phone] = @data_user.phone
    end
    if session[:cust_notes]
      @cust_notes = session[:cust_notes]
    end
    if session[:cart_po]
      cart = session[:cart_po]

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
  	redirect_to session.delete(:return_to)
  end

  def add_po_item
    product_id ||= params[:id]
   
    if session[:cart_po] 
      cart = session[:cart_po]
    else
      session[:cart_po] = {}
      cart = session[:cart_po]
    end
    if cart[product_id]
      #this line is really not important, will delete later..
      cart[product_id] = cart[product_id]
    else
      cart[product_id] = 1
    end
    redirect_to session.delete(:return_to)
  end

  def addquantity
  new_quantity = params[:quantity] 
  product_id = params[:product_id]

  #menyimpan customer notes
  session[:cust_notes] = params[:cust_notes]

	cart = session[:cart]
	#index disini sebagai penunjuk urutan array dari new_quantity
  #key adalah id, index adalah 0,1,2,3,4
	product_id.each_with_index do |key,index|
		cart[key] = new_quantity[index]
	end  
  	redirect_to :action => :index
  end

  def addquantity_po
  new_quantity = params[:quantity] 
  product_id = params[:product_id]
  #menyimpan customer notes
  session[:cust_notes] = params[:cust_notes]

  cart = session[:cart_po]
  #index disini sebagai penunjuk urutan array dari new_quantity
  #key adalah id, index adalah 0,1,2,3,4
  product_id.each_with_index do |key,index|
    cart[key] = new_quantity[index]
  end  
    redirect_to :action => :index_po
  end

  def checkout_member
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
    @user = User.find_by(:id => session[:user_id])
    @order = Order.new
    @inventory_order = @order.inventory_orders.build
    @cust_notes = session[:cust_notes]
  end

  def checkout_po_member
    if session[:cart_po]
      cart = session[:cart_po]

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
    @user = User.find_by(:id => session[:user_id])
    @order = Order.new
    @inventory_order = @order.inventory_orders.build
    @cust_notes = session[:cust_notes]
  end

  def checkout_visitor
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
    #checkout dengan data visitor tanpa signup menjadi member
    @customer = Customer.find_by(:id => params[:customer_id])
  	@order = Order.new
  	@inventory_order = @order.inventory_orders.build
    @cust_notes = session[:cust_notes]
  end

  def checkout_po_visitor
    if session[:cart_po]
      cart = session[:cart_po]

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
    #checkout dengan data visitor tanpa signup menjadi member
    @customer = Customer.find_by(:id => params[:customer_id])
    @order = Order.new
    @inventory_order = @order.inventory_orders.build
    @cust_notes = session[:cust_notes]
  end

  def clear
  	id = params[:id]
  	session[:cart].delete id
  	if session[:cart] == {}
  		session[:cart] = nil
      session[:cust_notes] = nil
  	end
  	redirect_to :action => :index
  end

  def clear_po
    id = params[:id]
    session[:cart_po].delete id
    if session[:cart_po] == {}
      session[:cart_po] = nil
      session[:cust_notes] = nil
    end
    redirect_to :action => :index_po
  end
end
