class PosterController < ApplicationController
	def index
		@poster = Poster.all
	end
	def new
		
	end
  
  	def create
  	end

  def destroy
    @product_image.destroy
    respond_to do |format|
      format.html { redirect_to product_images_url, notice: 'Product image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
