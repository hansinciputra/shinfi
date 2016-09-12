class CraftMaterialsController < ApplicationController
	def create
	@craft_material = CraftMaterial.new(craft_material_params)

	    if @craft_material.save
	      redirect_to karya_crafts_path, :notice => "Berhasil Menginput Craft Baru"
	    else
	      #need to reproduce all required file first  || craft_path(:id=>@craft_material.craft_id[0])
	    @categories = Category.all
	    @subcategories = Subcategory.all
	      #use render new to show error
	      render :new
	    end
  	end
end
