class CraftsController < ApplicationController
  before_action :set_craft, only: [:show, :edit, :update, :destroy]

  # GET /crafts
  # GET /crafts.json
  def index
    @craft = Craft.all
    
  end

  def user_craft
    @craft = Craft.where(:user_id => params[:user_id])
  end
  def craft_product
    
    @craft = Craft.get_craft.paginate(:page => params[:page],:per_page => 24)
    @craft = @craft.brand(params[:crafts][:brand]) if params[:crafts] && params[:crafts][:brand].present?
    @craft = @craft.minprice(params[:crafts][:min]) if params[:crafts] && params[:crafts][:min].present?
    @craft = @craft.maxprice(params[:crafts][:max]) if params[:crafts] && params[:crafts][:max].present?
     @craft = @craft.category(params[:category]) if params[:category].present?

    @category = Craft.select('DISTINCT category as category');   
    @brand = Brand.all 
    @banner = Poster.where(:type => "Banner")
    @lowestprice = PriceDet.minimum('price')
    @highestprice = PriceDet.maximum('price')
  end
  # GET /crafts/1
  # GET /crafts/1.json
  def show
    craftid = Craft.where(:slug=>params[:id])
    @craft_image = ProductImage.where(:craft_id => craftid[0].id)
    @price_dets = PriceDet.where(:craft_id => craftid[0].id)
    @brand = Brand.joins(:crafts).select('brands.id,brands.name,brands.brand_pic,crafts.id as craft_id').find_by('crafts.slug' => params[:id])
    @user = User.joins(:crafts).select('users.id,users.name,users.profpic').find_by('crafts.slug' => params[:id])
  end

  # GET /crafts/new
  def new
    @craft = Craft.new
    @categories = Category.all
    @subcategories = Subcategory.all
    @user = User.find_by(:id=>params[:user_id])
  end


  def admin_new_craft
    @craft = Craft.new
    @categories = Category.all
    @subcategories = Subcategory.all
    @user = User.all
    @brand = Brand.all
    @price_dets = @craft.price_dets.build
  end

  #custom craft section===========================================================
  def new_custom_craft
    @craft = Craft.find(params[:id])
    @user = User.find_by(:id=>@craft.user_id)
    @category = Material.select(:purpose).uniq.where(:user_id => @craft.user_id)
    
    #not neccesarry
    #selected_category = session[:custom_craft_categories]
    #@materials = Material.material_on_category(selected_category)
    
    @purpose = session[:custom_craft_categories]
  end
  def custom_craft_step1
    #first step, we set new session that will store data from step 1, also insert some signal that step 1 has been completed
    custom_craft = session[:custom_craft]
    session[:custom_craft_categories] = params[:category_selected]
    #redirect to back to begin the next step
    redirect_to :back
  end
  def custom_craft_step3
    #first step, we set new session that will store data from step 1, also insert some signal that step 1 has been completed
    @craft = Craft.find_by(:id=>params[:craft_id])
    custom_craft = session[:custom_craft]
    session[:custom_craft_categories] = params[:category_selected]
    session[:material_selected] = params[:material_selected]

    @material = []
    session[:material_selected].each do |x|
      temp = Material.find(x) 
      @material << temp
    end
    @categories = Category.all
    @subcategories = Subcategory.all
    @craft_material = @craft.craft_materials.build
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
      redirect_to new_custom_craft_crafts_path(:id=>@craft.id), :notice => "Berhasil Menginput Craft Baru"
    else
      #need to reproduce all required file first
    @categories = Category.all
    @subcategories = Subcategory.all
      #use render new to show error
      render :new
    end
  end

  def admin_create
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
      @craft = Craft.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def craft_params
      params.require(:craft).permit(:name, :PriceDet_id, :user_id, :category, :price_determinant,:subcategory, :prod_desc, :brand_id, :quantity, :active, :price_dets_attributes => [:id,:subject,:price,:availablity,:_destroy],:product_images_attributes => [:id,:prod_img,:remove_prod_img,:displaypic],:craft_materials_attributes => [:craft_id,:material_id,:price])
    end
end
