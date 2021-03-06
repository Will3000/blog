class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :reset]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    if params[:user]
      user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
    else
      user_params = params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar) unless params[:user]
    end

    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "You'are now signed up!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :old_password, :password, :password_confirmation, :avatar)
    if user_params[:old_password]
      if current_user && @user.authenticate(user_params[:old_password]) && user_params[:old_password] != user_params[:password]
        user_params.delete(:old_password)
        @user.update user_params
        redirect_to user_path(current_user),notice: "Update Sucessfully"
      else
        flash[:alert] = "Invalid Updates"
        render :edit
      end
    else
      if @user.update(user_params)
        redirect_to root_path, notice: "Update Sucessfully"
      else
        flash[:alert] = "Invalid Updates"
        render :edit
      end
    end
  end

  def reset

  end


  private
  def find_user
    @user = User.find(session[:user_id])
  end

end
