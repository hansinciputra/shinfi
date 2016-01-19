class UsersController < ApplicationController
  before_filter :authorize, except: [:login]
  def index
    @user = User.all
  end
  def login
  end
  def show
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(user_params)

  	if @user.save
  		redirect_to root_path, :notice => "Signed Up!"
  	else
  		render "new", :notice => "Gagal,Coba lagi!"
  	end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'Users was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, :notice => "User telah berhasil di delete"
    
    end
  end

end
  


def user_params
	params.require(:user).permit(:name,:email,:role,:password,:password_confirmation)
end
