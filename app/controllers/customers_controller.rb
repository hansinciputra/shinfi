class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :destroy]
  before_filter :authorize, only: [:show, :edit, :update, :destroy]
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    #to prevent user from inserting another new customer on head menu
    data_customer = Customer.where(:user_id => session[:user_id])
      data_customer.each do |data|
        session[:customer_id] = data.user_id
        @customer = Customer.where(:user_id => session[:user_id])
      end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    respond_to do |format|
      if @customer.save
        if @user && @user.role == 'Admin'
          format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        elsif @user && @user.role == 'Member'
          if session[:cart]
            #jika data diri di input pada saat melakukan pembayaran
            format.html { redirect_to cart_checkout_member_path(id = @customer), notice: 'Data anda berhasil di input.' }
          else
            #jika pertama kali login dan memasukan data diri
            format.html { redirect_to customer_path(@customer), notice: 'Data anda berhasil di input.' }
          end
          #jika guest
        else
          format.html { redirect_to cart_checkout_visitor_path(customer_id: @customer), notice: 'Silahkan lanjutkan proses Checkout' } 
        end
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name,:phone,:phone2,:address,:address2,:provinsi,:kota,:kodepos,:email,:signas,:user_id)
    end
end
