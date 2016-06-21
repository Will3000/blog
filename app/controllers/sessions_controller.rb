class SessionsController < ApplicationController
  def new
  end

  def create
    session[:attempt] |= 0;
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed In!"
    else
      session[:attempt] += 1;
      flash[:alert] = "Wrong credentials"
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed Out!"
  end

end
