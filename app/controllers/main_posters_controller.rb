class MainPostersController < ApplicationController
  before_action :set_image, only: [:destroy]
  before_filter :authorize

	def new
		@mainposter = MainPoster.new
		@listposter = Poster.where(:type => "MainPoster")
	end
  
  	def create
    	@mainposter = MainPoster.create(poster_image_params)
  	end

  def poster_image_params
      params.require(:main_poster).permit(:name, :type, :displaypic, :mainposter, :banner, :subposter, :squareposter)
  end

  def set_image
      @image = Poster.find(params[:id])
  end

  def destroy
    if @image.destroy
    FileUtils.rm_rf("#{Rails.root}/public/uploads/main_poster/mainposter/#{params[:id]}")
      redirect_to new_main_poster_path, :notice => "Gambar Telah Dihapus"
    else
      redirect_to new_main_poster_path, :notice => "Gambar Gagal Dihapus"
    end
  end
end
