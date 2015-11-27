class TypeInventoriesController < ApplicationController
	def index
		@type = TypeInventory.new
		@type_list = TypeInventory.all
	end
	def new
	end
	def create
		@type = TypeInventory.new(type_params)
		if @type.save
			redirect_to type_inventories_path,:notice => "New Type Added"
		else
			redirect_to type_inventories_path, :notice => "Failed to add new Type"
		end
	end
	def destroy
		@type = TypeInventory.find(params[:id])
		
		if @type.destroy
			redirect_to type_inventories_path,:notice => "Type Destroyed"
		else
			redirect_to type_inventories_path, :notice => "Failed to Destroy Type"
		end
	end
	def type_params
		params.require(:type).permit(:name)
	end
end
