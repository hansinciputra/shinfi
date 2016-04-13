class CategoriesController < ApplicationController
  def index
  	@categories = Category.all
    @subcategory = Subcategory.all
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

  def sub_categories_create
    @subcategories = Subcategory.new(subcategory_params)
    respond_to do |format|
      if @subcategories.save
         format.html { redirect_to categories_path, notice: 'SubCategory was successfully created.' }
      else
        format.html { redirect_to categories_path, notice: 'Fail to add SubCategory' }
      end
    end
  end

  def sub_categories_destroy
    @subcategories = Subcategory.find(params[:id])
    respond_to do |format|
      if @subcategories.destroy
         format.html { redirect_to categories_path, notice: 'SubCategory was successfully destroyed.' }
      else
        format.html { redirect_to categories_path, notice: 'Fail to destroy SubCategory' }
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
  def subcategory_params
    params.require(:subcategories).permit(:name, :category_id)
  end
end
