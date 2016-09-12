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

  #show custom crafts
  def karya
    @craft = Craft.find_by(:id=>params[:id])
    @material = CraftMaterial.joins(:material).select('materials.id,materials.name,materials.picture,materials.purpose,materials.quantity,materials.price,craft_materials.craft_id,craft_materials.selected,craft_materials.price as addprice').where(:craft_id => @craft.id).where(:selected => 'YES')
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
    @purpose = session[:custom_craft_categories]
  end

  def edit_custom_craft
    @craft = Craft.find(params[:id])
    @craftmaterial = CraftMaterial.joins(:material).select('craft_materials.id, craft_materials.material_id,materials.name,craft_materials.price').where(:craft_id=>@craft.id)
    @category = Material.select(:purpose).uniq.where(:user_id => @craft.user_id)


  end

  #code to edit the custom craft material step 1 ====================================
  def edit_custom_craft_materials_step1
    @craft = Craft.find_by(:id=>params[:id])
    @category = Material.select(:purpose).uniq.where(:user_id => @craft.user_id)

    #to display selected category
    #1st we get all selected category    
    @temp = CraftMaterial.joins(:material).select('materials.purpose').where(:craft_id => @craft.id).uniq
    #create an array to store the result
    @category_checked = []
    @temp.each do |x|
      #insert each selected category to the array
      @category_checked << x.purpose
    end

    #to default check selected custom craft
    #1st select all materials that is checked for this craft id
    @temp_checked = CraftMaterial.select('material_id').where(:selected => 'YES').where(:craft_id => @craft.id)
    @material_checked = []

    @temp_checked.each do |x|
      @material_checked << x.material_id
    end
    session[:custom_craft_categories] = params[:category_selected]
    session[:material_selected] = params[:material_selected]
    @purpose = session[:custom_craft_categories]

  end

  def edit_step1_save
    session[:custom_craft_categories] = params[:category_selected]
    session[:material_selected] = params[:material_selected]
    @craftmaterial = CraftMaterial.where(:craft_id=>params[:craft_id])

    @craftmaterial.each do |x|
      #if the first materials selected is not selected in the new edit selections,
      #we delete the unselected craftmaterials row from the table
      # .to_s because params store string inside the array not integer!  
      if params[:material_selected].include? x.material_id.to_s 
        #if params_selected already exist in the database, we set the selected to YES
        x.update_attribute(:selected ,'YES')    
      else
        x.delete_record(x.id)
      end
    end
    
    #if the selected material is not exist in the database, we add the new selected material to table
    #1. store the material_id to the temporary variable
    @variable = []
    @craftmaterial.each do |temp|
      @variable << temp.material_id
    end
    #2. for each data that exist in the params material_selected but not exist in the record
    # we create new record for craftmaterial
    params[:material_selected].each do |t|
      unless @variable.include? t.to_i
        CraftMaterial.add_record(t,params[:craft_id])
      end
    end
    redirect_to edit_custom_craft_craft_path
  end

  #edit the additional price of selected craft_materials
  def edit_custom_craft_materials_step2
    #first step, we set new session that will store data from step 1, also insert some signal that step 1 has been completed
    @craft = Craft.find_by(:id=>params[:id])
    @craft_material = CraftMaterial.where(:craft_id => @craft.id)
    @categories = Category.all
    @subcategories = Subcategory.all
  end
  def edit_step2_save
    @craft = Craft.friendly.find(params[:id])
    respond_to do |format|
      if @craft.update(craft_params)
        session[:custom_craft_categories] = nil
        session[:material_selected] = nil
        format.html { redirect_to edit_custom_craft_craft_path, notice: 'Craft was successfully updated.' }
        format.json { render :show, status: :ok, location: @craft }
      else
        format.html { render :edit }
        format.json { render json: @craft.errors, status: :unprocessable_entity }
      end
    end
  end

  #edit custom section end ==========================================================
  def custom_craft_step1
    #first step, we set new session that will store data from step 1, also insert some signal that step 1 has been completed
    custom_craft = session[:custom_craft]
    session[:custom_craft_categories] = params[:category_selected]
    #redirect to back to begin the next step
    redirect_to :back
  end

  #this is actualy step 2
  def custom_craft_step3
    #first step, we set new session that will store data from step 1, also insert some signal that step 1 has been completed
    @craft = Craft.find_by(:id=>params[:craft_id])
    #custom_craft = session[:custom_craft]
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
  #create for customized craft
  def create
    @craft = Craft.new(craft_params)
    if @craft.save
      #redirect to next step of custom craft creation
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
        session[:custom_craft_categories] = nil
        session[:material_selected] = nil
        format.html { redirect_to karya_crafts_path(:id=>@craft.id), notice: 'Craft was successfully updated.' }
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

  #to delet craft_material record on craft page
  def del_craft_material
    @craftmaterial = CraftMaterial.find(params[:id])
    @craftmaterial.destroy
      redirect_to :back,:notice => "Your post has been deleted successfully."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_craft
      @craft = Craft.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def craft_params
      params.require(:craft).permit(:name, :PriceDet_id, :user_id, :category, :price_determinant,:subcategory, :prod_desc, :brand_id, :quantity, :active, :price_dets_attributes => [:id,:subject,:price,:availablity,:_destroy],:product_images_attributes => [:id,:prod_img,:remove_prod_img,:displaypic],:craft_materials_attributes => [:id,:craft_id,:material_id,:price,:selected])
    end
end
