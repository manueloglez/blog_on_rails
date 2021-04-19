class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new()
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path 
    else
      render :new
    end
  end
  def edit
    @user = current_user
  end
  def update
    if current_user.update user_params
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation)
  end
end
