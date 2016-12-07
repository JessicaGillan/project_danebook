class SessionsController < ApplicationController
  skip_before_action :authenticate_user, except: [:destroy]

  def new
  end

  def create
    @user = User.find_by_email(params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      params[:remember] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "Signed in successfully."
      redirect_back_or(@user)
    else
      flash.now[:danger] = "Invalid information."
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = "Successfully signed out."
    redirect_to root_path
  end
end
