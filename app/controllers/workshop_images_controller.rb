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
  def set_dp
    #i don;t know why connector become format in this case
    WorkshopImage.setDisplayPic(params[:id],params[:format])
    redirect_to :back, :notice => 'Display Pic sudah diubah, Click Publish atau Save untuk menyimpan perubahan'
  end

  # DELETE /product_images/1
  # DELETE /product_images/1.json
  def destroy
    @workshop_images = WorkshopImage.find(params[:id])
    @workshop_images.destroy
    #back to previouse page with the same parameter
    redirect_to :back
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_image_params
      params.require(:workshop_image).permit(:craft_image, :connector, :display_pic, :workshop_id)
    end
end
