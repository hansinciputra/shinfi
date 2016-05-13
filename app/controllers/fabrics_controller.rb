class FabricsController < ApplicationController
	def index
    @image = Inventory.get_fabric.paginate(:page => params[:page],:per_page => 24)
    @image = @image.brand(params[:brand]) if params[:brand].present?
    @image = @image.brand(params[:fabrics][:brand]) if params[:fabrics] && params[:fabrics][:brand].present?
    @image = @image.fabrictype(params[:fabrictype]) if params[:fabrictype].present?
    @image = @image.fabrictype(params[:fabrics][:type]) if params[:fabrics] && params[:fabrics][:type].present?
    
    @image = @image.minprice(params[:fabrics][:min]) if params[:fabrics] && params[:fabrics][:min].present?
    @image = @image.maxprice(params[:fabrics][:max]) if params[:fabrics] && params[:fabrics][:max].present?
    if params[:category]
        params[:category].each do |t|
            @image = @image.category(params[:category]) if params[:category].present?
        end
    end    
    @banner = Poster.where(:type => "Banner")
    @category = Category.all
    @brand = Brand.all
    @lowestprice = Inventory.minimum('sellprice')
    @highestprice = Inventory.maximum('sellprice')
	end

    def brand_caller
        @banner = Poster.where(:type => "Banner")
        @category = Category.all
        @image = ProductImage.getAllProduct.where(:inventories => {:brand_id => params[:id]}).paginate(:page => params[:page],:per_page => 24)
    end
end
