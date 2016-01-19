class FabricsController < ApplicationController
	def index
	if(params[:type])
     @image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.sellprice').where(:inventories=>{:fabrictype => params[:type]}).paginate(:page => params[:page],:per_page => 9)
    elsif(params[:category])
   		@image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.sellprice').where(:inventories=>{:category => params[:category]}).paginate(:page => params[:page],:per_page => 9)
    else
     @image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.sellprice').where(:displaypic => 1).paginate(:page => params[:page],:per_page => 9)
    end
    @category = Category.all
	end
end
