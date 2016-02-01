class SubPostersController < ApplicationController
  before_action :set_image, only: [:destroy]
  before_filter :authorize

	def new
		@subposter = SubPoster.new
		@listsubposter = Poster.where(:type => "SubPoster")
	end
  
  	def create
    	@subposter = SubPoster.create(poster_image_params)
  	end

  def poster_image_params
      params.require(:sub_poster).permit(:name, :type, :displaypic, :mainposter, :banner, :subposter, :squareposter)
  end

  def set_image
      @image = Poster.find(params[:id])
  end

  def destroy
    if @image.destroy
    FileUtils.rm_rf("#{Rails.root}/public/uploads/sub_poster/subposter/#{params[:id]}")
      redirect_to new_sub_poster_path, :notice => "Gambar Telah Dihapus"
    else
      redirect_to new_sub_poster_path, :notice => "Gambar Gagal Dihapus"
    end
  end
end
