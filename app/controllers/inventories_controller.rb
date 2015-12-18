class InventoriesController < ApplicationController
  before_filter :authorize
  def index #to display all results
    @inventories = Inventory.all.order(:name)

  end
  def show #to display specified results
    @inventory = Inventory.find(params[:id])
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
    @product_images = @inventory.product_images.build
  end

  def create #no view, only process the form in the new actions
    @inventory = Inventory.new(inventory_params)
    
    if @inventory.save
      redirect_to inventories_path, :notice => "Berhasil Menginput Inventori"
    else
      redirect_to inventories_new_path, :notice => "Gagal Menginput Inventory"
    end
  end
  
  def edit #to display the edit form
    @inventory = Inventory.find(params[:id])
    @categories = Category.all 
    @type = TypeInventory.all
    @product_images_show = ProductImage.find_by inventory_id: @inventory.id
    @product_images = @inventory.product_images.build
  end
  
  def update #no view, only process the form in edit actions
    @inventory = Inventory.find(params[:id]) #this to find the post that we wanted to update, the id is from parameters when submit button is pressed
    
    #get the inventory parameters from user input , we get the data from from_for @inventory in edit view
    if @inventory.update_attributes(inventory_params)
      redirect_to edit_inventory_path(@inventory) , :notice => "Inventori Berhasil Terupdate"
    else
      render "edit"
    end
  end
  def destroy #no view, only process 
    @inventory = Inventory.find(params[:id])
    #simply use .destroy method to delete inventory 
    @inventory.destroy
    redirect_to inventories_path, :notice => "Inventori Telah Dihapus"
  end
  
  def remove_photo
    @inventory = Inventory.find(params[:id])
    @image_id = ProductImage.find(params[:prod_id])

    @image_id.destroy
    redirect_to edit_inventory_path(@inventory), :notice => "Inventori Telah Dihapus"
  end
  def inventory_params
    params.require(:inventory).permit(:name,:material,:fabrictype,:link, :quantity, :meter, :weight, :sellprice, :category, :prod_img,:product_images_attributes => [:id,:prod_img,:remove_prod_img])
  end
end
