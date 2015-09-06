class InventoriesController < ApplicationController
  def index #to display all results
    @inventories = Inventory.all
    
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
  end

  def create #no view, only process the form in the new actions
    @inventory = Inventory.new(params.require(:inventory).permit(:pName, :pQuantity, :pMeter, :pWeight, :pSellPrice, :pCategory, :image))
    
    if @inventory.save
      redirect_to inventories_path, :notice => "Berhasil Menginput Inventori"
    else
      render "new"
    end
  end
  
  def edit #to display the edit form
    @inventory = Inventory.find(params[:id])
   
  end
  
  def update #no view, only process the form in edit actions
    @inventory = Inventory.find(params[:id]) #this to find the post that we wanted to update, the id is from parameters when submit button is pressed
    
    #get the inventory parameters from user input , we get the data from from_for @inventory in edit view
    if @inventory.update_attributes(params.require(:inventory).permit(:pName, :pQuantity, :pMeter, :pWeight, :pSellPrice, :pCategory, :image))
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
  
end
