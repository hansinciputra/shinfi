class CompinfosController < ApplicationController
  before_filter :authorize
  before_action :set_compinfo, only: [:edit, :update, :destroy]

  # GET /compinfos
  # GET /compinfos.json
  def index
    @compinfos = Compinfo.all
  end

  # GET /compinfos/1
  # GET /compinfos/1.json
  def show
    @compinfo = Compinfo.where(:infotype => params[:id])
  end

  # GET /compinfos/new
  def new
    @compinfo = Compinfo.new
  end

  # GET /compinfos/1/edit
  def edit
    @user = User.find(session[:user_id])
  end

  # POST /compinfos
  # POST /compinfos.json
  def create
    @compinfo = Compinfo.new(compinfo_params)

    respond_to do |format|
      if @compinfo.save
        format.html { redirect_to edit_compinfo_path(@compinfo), notice: 'Compinfo was successfully created.' }
        format.json { render :show, status: :created, location: @compinfo }
      else
        format.html { render :new }
        format.json { render json: @compinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compinfos/1
  # PATCH/PUT /compinfos/1.json
  def update
    respond_to do |format|
      if @compinfo.update(compinfo_params)
        format.html { redirect_to edit_compinfo_path(@compinfo), notice: 'Compinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @compinfo }
      else
        format.html { render :edit }
        format.json { render json: @compinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compinfos/1
  # DELETE /compinfos/1.json
  def destroy
    @compinfo.destroy
    respond_to do |format|
      format.html { redirect_to compinfos_url, notice: 'Compinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compinfo
      @compinfo = Compinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compinfo_params
      params.require(:compinfo).permit(:title, :content, :infotype, :creator)
    end
end
