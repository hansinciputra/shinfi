class MaterialsController < ApplicationController
  before_filter :authorize
  before_action :set_material, only: [:show, :edit, :update, :destroy]
  before_action :set_userid

  def set_userid
    @materials = Material.where(:user_id => params[:user_id])
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_material
    @material = Material.find(params[:id])
  end
  # GET /materials
  # GET /materials.json
  def index
    @material = Material.new
    @test = User.all
    @purpose = Material.select(:purpose).uniq.where(:user_id => params[:user_id])
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # GET /materials/1/edit
  def edit
    @test = User.all
    @purpose = Material.select(:purpose).uniq.where(:user_id => params[:user_id])
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = Material.new(material_params)

    respond_to do |format|
      if @material.save
        format.html { redirect_to :back, notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to materials_path(:user_id=>@material.user_id), notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:name, :purpose, :picture, :quantity, :price, :user_id)
    end
end
