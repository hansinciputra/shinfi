class WorkshopImagesController < ApplicationController

  before_filter :authorize, :except => :show

  def index
 
  end


  def show

  end

  def new
    @workshop_image = WorkshopImage.new
    render :layout => false #to remove layout
  end


  def edit

  end

  def create
    @workshop_images = WorkshopImage.create(workshop_image_params)
  end

  def update

  end

  # DELETE /product_images/1
  # DELETE /product_images/1.json
  def destroy
    @product_image.destroy
    respond_to do |format|
      format.html { redirect_to workshops_path(:user_id=>params[:user_id]), notice: 'Product image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_image_params
      params.require(:workshop_image).permit(:craft_image, :connector, :display_pic, :workshop_id)
    end
end
