class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:primary] = "Welcome, #{user.name}"
      redirect_to root_path
    else
      flash[:info] = "Wrong email or password"
      render :new
    end
  end

  def destroy
    flash[:primary] = "Signed Out"
    session[:user_id] = nil
    redirect_to root_path
  end
end
