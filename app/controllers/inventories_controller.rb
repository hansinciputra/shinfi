class InventoriesController < ApplicationController
  before_filter :authorize
  def index #to display all results
    @inventories = Inventory.all.order(:name)
  end
  def show #to display specified results
    @inventory = Inventory.find(params[:id])
       respond_to do |format|
          format.html
          format.js
       end
  end
  def new #to display a form to create a new post
    @inventory = Inventory.new
    @categories = Category.all 
    @type = TypeInventory.all
  end

  def create #no view, only process the form in the new actions
    @inventory = Inventory.new(inventory_params)
    
    if @inventory.save
      redirect_to inventories_path, :notice => "Berhasil Menginput Inventori"
    else
      render "new"
    end
  end
  
  def edit #to display the edit form
    @inventory = Inventory.find(params[:id])
    @categories = Category.all 
    @type = TypeInventory.all
  end
  
  def update #no view, only process the form in edit actions
    @inventory = Inventory.find(params[:id]) #this to find the post that we wanted to update, the id is from parameters when submit button is pressed
    
    #get the inventory parameters from user input , we get the data from from_for @inventory in edit view
    if @inventory.update_attributes(inventory_params)
      redirect_to inventories_path , :notice => "Inventori Berhasil Terupdate"
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
  def inventory_params
    params.require(:inventory).permit(:name,:material,:fabrictype,:link, :quantity, :meter, :weight, :sellprice, :category, :image)
  end
end
