class CraftsController < ApplicationController
  before_action :set_craft, only: [:show, :edit, :update, :destroy]

  # GET /crafts
  # GET /crafts.json
  def index
    @craft = Craft.all
    
  end

  def craft_product
    sql = "SELECT crafts.name,crafts.id,price_dets_temp.craft_id, crafts.category,crafts.subcategory,crafts.user_id,crafts.brand_id,price_dets_temp.subject,price_dets_temp.pd_price_row,price_dets_temp.price,product_images.prod_img,product_images.displaypic,product_images.craft_id 
          FROM crafts INNER JOIN(
                SELECT price_dets.craft_id,
                price_dets.subject, 
                price_dets.price,
                row_number() over(partition by price_dets.craft_id )as pd_price_row from price_dets 
                GROUP BY price_dets.craft_id,price_dets.subject,price_dets.price)price_dets_temp ON crafts.id = price_dets_temp.craft_id 
                AND price_dets_temp.pd_price_row = 1 INNER JOIN product_images ON price_dets_temp.craft_id = product_images.craft_id AND product_images.displaypic = 1"
    @craft = Craft.paginate_by_sql(sql,:page => params[:page],:per_page => 24)
    #@craft = ProductImage.joins(:craft).join(:price_dets).select('crafts.name,crafts.id,crafts.category,crafts.subcategory,crafts.user_id,crafts.brand_id,price_dets.subject,price_dets.price,product_images.prod_img,product_images.displaypic,product_images.craft_id').where('product_images.displaypic = 1').paginate(:page => params[:page],:per_page => 24)
    @brand = Brand.all 
    @banner = Poster.where(:type => "Banner")
  end
  # GET /crafts/1
  # GET /crafts/1.json
  def show
    @craft_image = ProductImage.find_by(:craft_id => params[:id])
    @price_dets = PriceDet.where(:craft_id => params[:id])
  

  end

  # GET /crafts/new
  def new
    @craft = Craft.new
    @categories = Category.all
    @subcategories = Subcategory.all
    @user = User.all
    @brand = Brand.all
    @price_dets = @craft.price_dets.build
  end

  # GET /crafts/1/edit
  def edit
    @categories = Category.all
    @subcategories = Subcategory.all
    @user = User.all
    @brand = Brand.all
    @displaypic = ProductImage.find_by(:craft_id => params[:id])
    @price_dets = @craft.price_dets.build
  end

  # POST /crafts
  # POST /crafts.json
  def create
    @craft = Craft.new(craft_params)
    if @craft.save
      redirect_to new_product_image_path(:id=>@craft), :notice => "Berhasil Menginput Craft Baru"
    else
      #need to reproduce all required file first
    @categories = Category.all
    @subcategories = Subcategory.all
    @user = User.all
    @brand = Brand.all
      #use render new to show error
      render :new
    end
  end

  # PATCH/PUT /crafts/1
  # PATCH/PUT /crafts/1.json
  def update
    respond_to do |format|
      if @craft.update(craft_params)
        format.html { redirect_to @craft, notice: 'Craft was successfully updated.' }
        format.json { render :show, status: :ok, location: @craft }
      else
        format.html { render :edit }
        format.json { render json: @craft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crafts/1
  # DELETE /crafts/1.json
  def destroy
    @craft.destroy
    respond_to do |format|
      format.html { redirect_to crafts_url, notice: 'Craft was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_craft
      @craft = Craft.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def craft_params
      params.require(:craft).permit(:name, :PriceDet_id, :user_id, :category, :price_determinant,:subcategory, :prod_desc, :brand_id, :quantity, :active, :price_dets_attributes => [:id,:subject,:price,:availablity,:_destroy],:product_images_attributes => [:id,:prod_img,:remove_prod_img,:displaypic])
    end
end
