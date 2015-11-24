class OrderPosController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, except: [:show]
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    if params[:order_pos] && params[:order_pos][:status]
    @orders_index = Order.find_by_sql(["SELECT orders_temp.id , 
      orders_temp.payment, orders_temp.status, customers.name , 
      sum(inventories.sellprice*inventory_orders.quantity) + COALESCE(orders_temp.ongkir,0) - COALESCE(orders_temp.discount,0) AS total_price, 
      sum(inventories.sellprice*inventory_orders.quantity)- COALESCE(orders_temp.payment,0) AS outstanding 
      FROM customers LEFT JOIN (SELECT orders.id,orders.ongkir, orders.discount, orders.payment, orders.customer_id, orders.readyorpo, order_statuses.id AS status FROM orders LEFT JOIN order_statuses on orders.order_status_id = order_statuses.id
)orders_temp on customers.id = orders_temp.customer_id LEFT JOIN inventory_orders on orders_temp.id = inventory_orders.order_id LEFT JOIN inventories on inventory_orders.inventory_id = inventories.id  WHERE orders_temp.readyorpo = 'PO' AND orders_temp.status = ? GROUP BY orders_temp.id, orders_temp.payment, orders_temp.status,orders_temp.ongkir,orders_temp.discount, customers.name ORDER BY id", params[:order_pos][:status]])  
 
    else
    @orders_index = Order.find_by_sql("SELECT orders_temp.id , orders_temp.payment, orders_temp.status, customers.name , sum(inventories.sellprice*inventory_orders.quantity) + COALESCE(orders_temp.ongkir,0) - COALESCE(orders_temp.discount,0) AS total_price, sum(inventories.sellprice*inventory_orders.quantity)- COALESCE(orders_temp.payment,0) AS outstanding FROM customers LEFT JOIN (SELECT orders.id,orders.ongkir,orders.discount, orders.payment, orders.customer_id, orders.readyorpo, order_statuses.id AS status FROM orders LEFT JOIN order_statuses on orders.order_status_id = order_statuses.id
)orders_temp on customers.id = orders_temp.customer_id LEFT JOIN inventory_orders on orders_temp.id = inventory_orders.order_id LEFT JOIN inventories on inventory_orders.inventory_id = inventories.id  WHERE orders_temp.readyorpo = 'PO' GROUP BY orders_temp.id, orders_temp.payment, orders_temp.status, orders_temp.discount, orders_temp.ongkir, customers.name ORDER BY id")
   end
   @orderstatus = OrderStatus.all
  end 
  # GET /orders/1
  # GET /orders/1.json
  def show
    @orders = Order.find(params[:id])
    @inventory_ordered = Order.find_by_sql(["SELECT inventories.name, inventories.sellprice, inventory_orders.quantity , inventories.sellprice*inventory_orders.quantity as Total FROM inventories LEFT JOIN inventory_orders on inventories.id = inventory_orders.inventory_id WHERE inventory_orders.order_id = ? ORDER BY inventories.name", params[:id]]);
    @total_ordered = Order.find_by_sql(["select sum(inventories.sellprice*inventory_orders.quantity) as total_price from inventories left join inventory_orders on inventories.id = inventory_orders.inventory_id where inventory_orders.order_id = ?", params[:id]])
    @down_payment_calculation = Order.find_by_sql(["SELECT orders.payment, sum(inventories.sellprice*inventory_orders.quantity) - COALESCE(orders.payment,0) as outstanding From inventories LEFT JOIN inventory_orders on inventories.id = inventory_orders.inventory_id LEFT JOIN orders on inventory_orders.order_id = orders.id where order_id = ? GROUP BY orders.payment", params[:id]]);
    @total_amount = Order.find_by_sql(["select sum(inventories.sellprice*inventory_orders.quantity) + COALESCE(orders.ongkir,0) - COALESCE(orders.discount,0) as total_amount FROM inventories LEFT JOIN inventory_orders on inventories.id = inventory_orders.inventory_id LEFT JOIN orders on inventory_orders.order_id = orders.id where order_id = ? GROUP BY orders.payment, orders.ongkir,orders.discount", params[:id]]);
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
    @customer = Customer.all
    @edt_inv = Order.find_by_sql(["select inventories.id as inventory_id, inventories.name, inventories.meter, inventories.sellprice, inventories.quantity as stock_left, temp.id as id, temp.quantity FROM inventories LEFT OUTER JOIN (select * from inventory_orders where inventory_orders.order_id = ?)temp on inventories.id = temp.inventory_id" , params[:id]])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_po_path(@order), notice: 'Order was successfully created.' }
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
        format.html { redirect_to order_po_path(@order), notice: 'Order was successfully updated.' }
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
      format.html { redirect_to order_pos_path, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def update_multiple_payment
    @order = Order.find(params[:order_pos][:id])
     if @order.update_attributes(params.require(:order_pos).permit(:payment, :order_status_id))
      redirect_to order_pos_path , :notice => "Payment Berhasil Terupdate"
    else
      redirect_to order_pos_path , :notice => "Payment Gagal Terupdate"
    end

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:ongkir,:discount,:readyorpo, :customer_id, :order_ids => [],:inventory_orders_attributes => [:id, :quantity, :inventory_id ])
      #specify [:id,:inventory_id, :quantity], otherwhise record when edit each record will be created again
    end
end
