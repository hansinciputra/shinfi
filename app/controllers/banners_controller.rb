class BannersController < ApplicationController
  before_action :set_image, only: [:destroy]
  before_filter :authorize

	def new
		@banner = Banner.new
		@listbanner = Poster.where(:type => "Banner")
	end
  
  	def create
    	@banner = Banner.create(poster_image_params)
  	end

  def poster_image_params
      params.require(:banner).permit(:name, :type, :displaypic, :mainposter, :banner, :subposter, :squareposter)
  end

  def set_image
      @image = Poster.find(params[:id])
  end

  def destroy
    if @image.destroy
    FileUtils.rm_rf("#{Rails.root}/public/uploads/banner/banner/#{params[:id]}")
      redirect_to new_banner_path, :notice => "Gambar Telah Dihapus"
    else
      redirect_to new_banner_path, :notice => "Gambar Gagal Dihapus"
    end
  end
end
