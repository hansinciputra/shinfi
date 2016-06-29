class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:update, :destroy]
  before_action :set_user, except: [:get_thumb_pic]
  before_filter :authorize, :except =>[:index, :show]

  def set_user
    @user = User.find_by(:id => params[:user_id])
  end
     # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find_by(:user_id => params[:user_id])
    end

  # GET /workshops
  # GET /workshops.json
  def index
    @workshops = Workshop.get_user_workshop(params[:user_id])
    @workshops_published = @workshops.published 
    @workshops_no_publish = @workshops.not_published 
  end
  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])
    @displayimage = WorkshopImage.where(:workshop_id => params[:id]).where(:display_pic => 'DP')
    @allimage = WorkshopImage.where(:workshop_id => params[:id])
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new

    @connector = SecureRandom.hex(5)
  end

  # GET /workshops/1/edit
  def edit
    @workshop = Workshop.find(params[:id])
    @workshop_images = WorkshopImage.find_by(:workshop_id => params[:id])
  end

  def get_thumb_pic
    @img = WorkshopImage.where(:connector => params[:connector])
  end
  # POST /workshops
  # POST /workshops.json
  def create
    if params[:commit] == 'Save & Quit'
      params[:workshop][:publish_status] = 'no_publish'
    elsif params[:commit] == 'Publish Now!'
      params[:workshop][:publish_status] = 'published'
    end
    @workshop = Workshop.new(workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: 'Workshop was successfully created.' }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshops/1
  # PATCH/PUT /workshops/1.json
  def update
    if params[:commit] == 'Save & Quit'
      params[:workshop][:publish_status] = 'no_publish'
    elsif params[:commit] == 'Publish Now!'
      params[:workshop][:publish_status] = 'published'
    end
    @workshop = Workshop.find(params[:id])
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to @workshop, notice: 'Workshop was successfully updated.' }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to workshops_url, notice: 'Workshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_params
      params.require(:workshop).permit(:connector,:craft_image, :title, :description, :user_id, :publish_status,:workshop_images_attributes => [:craft_image, :connector, :display_pic, :workshop_id])
    end
end
