class BrandsController < ApplicationController
	before_action :set_image, :only => [:edit,:update,:destroy]
	before_filter :authorize
	def set_image
		@image = Brand.find(params[:id])
	end
	def index
		@image = Brand.all
		@banner = Poster.where(:type => "Banner")
	end
	def new
		@brand = Brand.new
		@brandlogosaved = Brand.all
	end
	def create
		@brand = Brand.new(brand_image_params)
		if @brand.save
			redirect_to brands_path, notice: 'New Brand Listed.'
	  	else
	  		redirect_to brands_path, notice: 'Fail to add brand'
	  	end

	end
	def edit
		@brand = Brand.find(params[:id])

	end

	def update
		@brand = Brand.find(params[:id])

		if @brand.update(brand_image_params)
			redirect_to brands_path, notice: 'Berhasil Mengupdate Brand.'
		else
			redirect_to brands_path, notice: 'Gagal update brand'
		end

	end
	def brand_image_params
      params.require(:brand).permit(:name, :brand_pic)
  	end

	def destroy
    if @image.destroy
    FileUtils.rm_rf("#{Rails.root}/public/uploads/main_poster/mainposter/#{params[:id]}")
      redirect_to brands_path, :notice => "Gambar Telah Dihapus"
    else
      redirect_to brands_path, :notice => "Gambar Gagal Dihapus"
    end
  end
end