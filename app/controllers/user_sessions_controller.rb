class UserSessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to projects_url, notice: "Logged in successfully!!"
    elsif !user
      flash.alert = "Incorrect Email. Please try again."
      redirect_to login_path
    else
      flash.alert = "Incorrect password. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
