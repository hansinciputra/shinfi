class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @orders_index = Order.find_by_sql("SELECT orders.id , orders.status, customers.name , sum(inventories.sellprice*inventory_orders.quantity) as total_price FROM customers LEFT JOIN orders on customers.id = orders.customer_id LEFT JOIN inventory_orders on orders.id = inventory_orders.order_id LEFT JOIN inventories on inventory_orders.inventory_id = inventories.id GROUP BY orders.id, customers.name ORDER BY id")
    @inventories_list = Inventory.all #controller can call any model

  end 
  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @inventory_ordered = Order.find_by_sql(["SELECT inventories.name, inventories.sellprice, inventory_orders.quantity , inventories.sellprice*inventory_orders.quantity as Total FROM inventories LEFT JOIN inventory_orders on inventories.id = inventory_orders.inventory_id WHERE inventory_orders.order_id = ?", params[:id]]);
    @total_ordered = Order.find_by_sql(["select sum(inventories.sellprice*inventory_orders.quantity) as total_price from inventories left join inventory_orders on inventories.id = inventory_orders.inventory_id where inventory_orders.order_id = ?", params[:id]])

  end

  # GET /orders/new
  def new
    @order = Order.new
    @customer = Customer.all
    @inventories_list = Inventory.all #controller can call any model
    @inventory_order = @order.inventory_orders.build #to build instance of inventory order on the view page, otherwise the field_for will think that there is no inventory_order class and thus not showinf the field_for tag in the view
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @customer = Customer.all
    @inventories_list = Inventory.all
    @edt_inv = Order.find_by_sql(["select inventories.id as inventory_id, inventories.name, inventories.meter, inventories.sellprice, inventories.quantity as stock_left, temp.id as id, temp.quantity FROM inventories LEFT OUTER JOIN (select * from inventory_orders where inventory_orders.order_id = ?)temp on inventories.id = temp.inventory_id" , params[:id]])
    #@inventory_order = @order.inventory_orders.build
    #@order2 = InventoryOrder.find_by_order_id(params[:id])

  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new(order_params)
    @inventories_list = Inventory.all #controller can call any model
 
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :order_ids => [],:inventory_orders_attributes => [:id, :quantity, :inventory_id ])
      #specify [:id,:inventory_id, :quantity], otherwhise record when edit each record will be created again
    end
end
