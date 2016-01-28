class SessionsController < ApplicationController
  def new
  end
  def create
  	user = User.check_login(params[:email],params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to root_path, :notice =>"loged in!"
  	else
  		redirect_to root_path, :notice =>"Invalid Email or Password"
  	end
  end

  def destroy
  	session[:user_id] = nil
    session[:cart] = nil
    session[:customer_id] = nil
  	redirect_to root_path, :notice => "Logged Out!"
  end
end
