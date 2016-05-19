class ProductImagesController < ApplicationController
  before_action :set_product_image, only: [:update, :destroy]
  before_filter :authorize, :except => :show
  # GET /product_images
  # GET /product_images.json
  def index
    @product_images = ProductImage.all
  end

  # GET /product_images/1
  # GET /product_images/1.json
  def show
    #the params is set to get data from inventories.id -> from order show invoice page, thus the exception of before action no include :show
  @product_image = ProductImage.find_by(:inventory_id => params[:id])  
  @inventory_name = Inventory.find_by_sql(["SELECT product_images.id, product_images.inventory_id, inventories.name as name FROM inventories LEFT JOIN product_images on inventories.id = product_images.inventory_id WHERE inventories.id = ? LIMIT 1", params[:id]])
   render :layout => false #to remove layout
  end

  # GET /product_images/new
  def new
    #action new is called when uploading product when creating new Inventory
    @product_images = ProductImage.new
    @inventory = Inventory.find_by(:slug => params[:id])
    @craft = Craft.find_by(:slug => params[:id])
    @check_image = ProductImage.find_by(:inventory_id => params[:id])
  end

  # GET /product_images/1/edit
  def edit
    @product_images = ProductImage.find_by(:inventory_id => params[:id])
    @inventory = Inventory.find_by(:id => params[:id])
  end

  # POST /product_images
  # POST /product_images.json
  def create
    @product_images = ProductImage.create(product_image_params)
    @inventory = Inventory.find_by(:id => params[:id])
    
  end

  # PATCH/PUT /product_images/1
  # PATCH/PUT /product_images/1.json
  def update
    respond_to do |format|
      if @product_image.update(product_image_params)
        format.html { redirect_to @product_image, notice: 'Product image was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_image }
      else
        format.html { render :edit }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_images/1
  # DELETE /product_images/1.json
  def destroy
    @product_image.destroy
    respond_to do |format|
      format.html { redirect_to product_images_url, notice: 'Product image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_display_picture_craft
    @craft = Craft.find(params[:id])
    @product_image = ProductImage.setDisplayPic(params[:prod_id],params[:id],2)

    redirect_to edit_craft_path(@craft), :notice => "Berhasil di set sebagai Display Picture"
  end

  def set_display_picture_inventory
    @inventory = Inventory.find(params[:id])

    @product_image = ProductImage.setDisplayPic(params[:prod_id],params[:id],1)

    redirect_to edit_inventory_path(@inventory), :notice => "Berhasil di set sebagai Display Picture"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_image
      @product_image = ProductImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_image_params
      params.require(:product_image).permit(:name, :inventory_id, :displaypic, :prod_img,:craft_id)
    end
end
