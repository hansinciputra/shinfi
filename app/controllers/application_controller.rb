class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def index
    @best_seller = Order.best_seller_product_pic.take(5)
    @mainposter = Poster.where(:type => "MainPoster")
    @subposter1 = Poster.where(:type => "SubPoster")
    @new_order = Order.number_of_new_order('STOCKED').count
    @new_po_order = Order.number_of_new_order('PO').count
  end
  def current_user
  	if session[:user_id]
      #need to use find_by since we are using uuid
  		@current_user = User.find_by(:id => session[:user_id])
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
  def authorize_admin
    unless session[:role] == 'Admin'
      flash[:notice] = "Access Denied, Login first"
      redirect_to root_path
      return false
    else
      return true
    end
  end
end
