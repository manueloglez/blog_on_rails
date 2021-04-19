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

  def change_password
    @user = current_user
  end

  def update_password
    pass_params = params.permit(:current_password, :new_password, :new_password_confirmation)
    if current_user.authenticate(pass_params[:current_password]) && pass_params[:current_password] != pass_params[:new_password] && pass_params[:new_password] == pass_params[:new_password_confirmation]

      current_user.password = pass_params[:new_password]
      current_user.password_confirmation = pass_params[:new_password_confirmation]
      current_user.save!

      flash[:primary] = 'Password changed succesfully'
      redirect_to edit_user_path
    else
      flash[:danger] = 'Wrong parameters'
      redirect_to change_password_path(current_user)
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
