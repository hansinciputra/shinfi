class FabricsController < ApplicationController
	def index
        @banner = Poster.where(:type => "Banner")
	if(params[:type] && params[:warna])
        @image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.quantity,inventories.sellprice').where(:inventories=>{:warna => params[:warna]}).where(:inventories=>{:fabrictype => params[:type]}).where("inventories.prodtype = 'Fabric'").where("inventories.quantity > ?", 0).paginate(:page => params[:page],:per_page => 24)
    elsif(params[:type])
     @image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.quantity,inventories.sellprice').where(:inventories=>{:fabrictype => params[:type]}).where("inventories.prodtype = 'Fabric'").where("inventories.quantity > ?", 0).paginate(:page => params[:page],:per_page => 24)

    elsif(params[:fabrics] && params[:fabrics][:category])
        @image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.quantity,inventories.sellprice').where(:inventories=>{:category => params[:fabrics][:category]}).where("inventories.prodtype = 'Fabric'").where("inventories.quantity > ?", 0).paginate(:page => params[:page],:per_page => 24)
    elsif(params[:fabrics] && params[:fabrics][:category] && params[:fabrics][:type])
   		@image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.quantity,inventories.sellprice').where(:inventories=>{:category => params[:fabrics][:category]}).where(:inventories=>{:fabrictype => params[:fabrics][:type]}).where("inventories.prodtype = 'Fabric'").where("inventories.quantity > ?", 0).paginate(:page => params[:page],:per_page => 24)
       else
     @image = ProductImage.joins(:inventory).select('product_images.prod_img,product_images.id,product_images.inventory_id,inventories.name,inventories.category,inventories.fabrictype,inventories.quantity,inventories.sellprice').where(:displaypic => 1).where("inventories.prodtype = 'Fabric'").where("inventories.quantity > ?", 0).paginate(:page => params[:page],:per_page => 24)
    end
    @category = Category.all
	end
end
