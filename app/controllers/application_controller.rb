class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exeption

  helper_method :current_chef, :logged_in?, :current_user, :user_logged_in?

  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  def logged_in?
    !!current_chef
  end

  def required_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    !!current_user
  end

  def required_users
    if !user_logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end


end
