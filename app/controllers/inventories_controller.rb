class InventoriesController < ApplicationController
  def index #to display all results
    @inventories = Inventory.all
  end
  def show #to display specified results
    @inventory = Inventory.find(params[:id])
  end
  def new #to display a form to create a new post
    
  end

  def edit #to display the edit form
    
  end
  
  def create #no view, only process the form in the new actions
    
  end
  def update #no view, only process the form in edit actions
    
  end
  def destroy #no view, only process 
    
  end
  
end
