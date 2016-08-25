class CraftMaterialsController < ApplicationController
	def create
	@craft_material = CraftMaterial.new(craft_material_params)

	    if @craft_material.save
	      redirect_to :back, :notice => "Berhasil Menginput Craft Baru"
	    else
	      #need to reproduce all required file first  || craft_path(:id=>@craft_material.craft_id[0])
	    @categories = Category.all
	    @subcategories = Subcategory.all
	      #use render new to show error
	      render :new
	    end
  	end
  	def craft_material_params
      params.require(:craft).permit(:craft_materials_attributes => [:craft_id,:material_id,:price])
    end
end
