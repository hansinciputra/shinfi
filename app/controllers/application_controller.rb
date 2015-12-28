class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def index
    @image = ProductImage.where(:displaypic => 1)
  end
  def current_user
  	if session[:user_id]
  		@current_user = User.find(session[:user_id])
  	end
  end
  def authorize
  	unless session[:user_id]
  		flash[:notice] = "Access Denied, Login first"
  		redirect_to root_path
  		return false
  	else
  		return true
  	end
  end
end
