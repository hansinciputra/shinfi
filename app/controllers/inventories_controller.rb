class InventoriesController < ApplicationController
  before_filter :authorize, :except => [:show]
  before_action :set_id, only: [:show, :edit, :update, :destroy]
  def index #to display all results
    @inventories = Inventory.all.order(:name)

  end
  def show #to display specified results
    if @inventory.brand_id
      @brand = Brand.show_brand_on_id(@inventory.brand_id)
    end
    @product_images = ProductImage.find_by inventory_id: @inventory.id
       respond_to do |format|
          format.html
          format.js
       end
  end
  def new #to display a form to create a new post
    @inventory = Inventory.new
    @categories = Category.all 
    @type = TypeInventory.all
    @productype = Prodtype.all
    @brands = Brand.all
    @product_images = @inventory.product_images.build
  end

  def create #no view, only process the form in the new actions
    @inventory = Inventory.new(inventory_params)
    
    if @inventory.save
      redirect_to new_product_image_path(:id=>@inventory), :notice => "Berhasil Menginput Inventori"
    else
      #need to reproduce all required file first
      @productype = Prodtype.all
      @categories = Category.all 
      @type = TypeInventory.all
      @brands = Brand.all
      #use render new to show error
      render :new
    end
  end
  
  def edit #to display the edit form
   
    @categories = Category.all 
    @type = TypeInventory.all
    @productype = Prodtype.all
    @brands = Brand.all
    @product_images = @inventory.product_images.build
  end

  def set_id
   @inventory = Inventory.friendly.find(params[:id])
  end

  def update #no view, only process the form in edit actions   
    #get the inventory parameters from user input , we get the data from from_for @inventory in edit view
    if @inventory.update_attributes(inventory_params)
      redirect_to edit_inventory_path(@inventory) , :notice => "Inventori Berhasil Terupdate"
    else
      render "edit"
    end
  end
  def destroy #no view, only process 
    @image = ProductImage.where(:inventory_id => params[:id])
    #simply use .destroy method to delete inventory 
    if @inventory.destroy
      @image.each do |images|
        #supposed to delete the image folder, but not working @_@
        FileUtils.rm_rf("#{Rails.root}/public/uploads/product_image/prod_img/#{images.id}")
      end
      redirect_to inventories_path, :notice => "Inventori Telah Dihapus"
    else
      redirect_to inventories_path, :notice => "Inventori Gagal Dihapus"
    end
  end
  
  def remove_photo
    @inventory = Inventory.find(params[:id])
    @image_id = ProductImage.find(params[:prod_id])

    if @image_id.destroy
      #if we change database location to amazon S3, need to change this folder directory too
      FileUtils.rm_rf("#{Rails.root}/public/uploads/product_image/prod_img/#{params[:prod_id]}")
      redirect_to edit_inventory_path(@inventory), :notice => "Gambar Telah Dihapus"
    else
      redirect_to edit_inventory_path(@inventory), :notice => "Gambar Gagal Dihapus"
    end
  end

  def import_product
  end

  def import
    Inventory.import(params[:file])
    redirect_to inventories_path, :notice => "Inventories Berhasil Di import, Harap lakukan sample checking"
  end

  def inventory_params
    params.require(:inventory).permit(:id,:name,:material,:fabrictype,:link, :quantity, :meter, :weight, :sellprice, :prodtype,:category,:brand_id,:satuan,:ukuran,:berat,:warna, :prod_img,:product_images_attributes => [:id,:prod_img,:remove_prod_img,:displaypic])
  end
end
