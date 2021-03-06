class ProdtypesController < ApplicationController
  # GET /prodtypes
  # GET /prodtypes.json
  def index
    @prodtype = Prodtype.new
    @prodtypes = Prodtype.all 
  end

  # GET /prodtypes/new
  def new
  end

  # POST /prodtypes
  # POST /prodtypes.json
  def create
    @prodtype = Prodtype.new(prodtype_params)

    respond_to do |format|
      if @prodtype.save
        format.html { redirect_to prodtypes_path, notice: 'Product type was successfully created.' }
        format.json { render :show, status: :created, location: @prodtype }
      else
        format.html { render :new }
        format.json { render json: @prodtype.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @prodtype = Prodtype.find(params[:id])
    
    if @prodtype.destroy
      redirect_to prodtypes_path,:notice => "Product Type Destroyed"
    else
      redirect_to prodtypes_path, :notice => "Failed to Destroy Product Type"
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def prodtype_params
      params.require(:prodtype).permit(:name)
    end
end
