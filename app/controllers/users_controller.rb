  class UsersController < ApplicationController
  before_action :set_user, only: [:edit,:user_detail,:change_password,:change_password_commit, :update, :destroy ,:show]
  before_filter :authorize, except: [:login,:new,:create]
  before_filter :authorize_admin, only: [:index]
  def set_user
    @user = User.find_by(:id => params[:id])
  end
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
      if session[:role] == 'Admin'
        redirect_to users_path, :notice => "Users Created successfully"
      else
  		  redirect_to login_users_path, :notice => "Signed Up, Silahkan Login dengan account anda!"
  	   end
    else
  		render "new", :notice => "Gagal,Coba lagi!"
  	end
  end
  def change_password
  #display halaman change password dengan menyertakan email dan id
  end
  def change_password_commit
    #cek apakah old password sesuai, jika ya, update password dengan password baru
    user = User.check_password(params[:user][:email],params[:user][:oldpassword])
    if user
        if @user.update(check_password_params)
          redirect_to change_password_user_path, :notice => "Password Telah diganti!" 
        else
          redirect_to change_password_user_path, :notice => "Password Gagal diganti!" 
        end
    else
       redirect_to change_password_user_path, :notice => "Password lama anda salah!"
    end
  end
  def edit
    
  end

  def user_detail

  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if session[:cart]
          format.html { redirect_to cart_index_path, notice: 'Silahkan Melanjutkan proses checkout.' }
        else
          format.html { redirect_to user_path, notice: 'Users was successfully updated.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
  #since we have no id in user table, the usual @user.destroy will not work, since rails convention require each table to have id...thus we use delete_all , this is dangerous if we have no unique id
    @user = User.delete_all(:id => params[:id])
   
      redirect_to users_path, :notice => "User telah berhasil di delete"
  
  end

end
  

def check_password_params
  params.require(:user).permit(:email,:password,:password_confirmation)
end

def user_params
	params.require(:user).permit(:name,:email,:kecamatan,:kelurahan,:fb_contact,:insta_contact,:role,:password,:password_confirmation,:phone,:phone2,:address,:address2,:provinsi,:kota,:kodepos)
end
