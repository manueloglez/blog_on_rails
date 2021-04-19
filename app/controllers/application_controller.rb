class ApplicationController < ActionController::Base
  private

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find session[:user_id]
    end
  end
  helper_method :current_user
  # "helper_method" it makes a method availabe to all views

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless user_signed_in?
      flash[:danger] = 'You must be logged in'
      redirect_to root_path
    end
  end
end
