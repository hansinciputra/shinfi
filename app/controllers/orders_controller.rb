class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @inventories_list = Inventory.all #controller can call any model
  end 
  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
    @inventories_list = Inventory.all #controller can call any model
    @inventory_order = @order.inventory_orders.build #to build instance of inventory order on the view page, otherwise the field_for will think that there is no inventory_order class and thus not showinf the field_for tag in the view
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new(order_params)
    @inventories_list = Inventory.all #controller can call any model
    #inv_id = params[:inventory_orders_attributes][:inv_id]
    #qty =  params[:inventory_orders][:quantity]
    #inv_id = @order.inventory_orders.build(params[:inv_id])
   # qty = @order.inventory_orders.build(params[:quantity])
    #inv_id = @inventory_order.build_inventory(params[:inv_id])

    #inventory_order = Inventory_order.new(order_id: @order.id, inventory_id: inv_id.id)

    respond_to do |format|
      if @order.save

        #InventoryOrder.create(order_id: @order.id, inventory_id: inv_id, quantity: qty)

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
      #specify [:id,:inv_id, :quantity], otherwhise record when edit each record will be created again
    end
end