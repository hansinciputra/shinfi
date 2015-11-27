class CategoriesController < ApplicationController
  def index
  	@categories = Category.all
  end
  def new
  	@categories = Category.new
  end

  def create
  	@categories= Category.new(category_params)
  	respond_to do |format|
	  	if @categories.save
	  		 format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
	  	else
	  		format.html { redirect_to categories_path, notice: 'Fail to add category' }
	  	end
	  end
  end

  def destroy
  	@category = Category.find(params[:id])
  	@category.destroy
  	respond_to do |format|
	  		 format.html { redirect_to categories_path, notice: 'Category was successfully destroyed.' }
	  end
  end

  def category_params
  	params.require(:categories).permit(:name)
  end
end
