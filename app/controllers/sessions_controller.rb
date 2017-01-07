class SessionsController < ApplicationController
  skip_before_action :require_logged_in, except: [:destroy]

  def new
  end

  def create
    @user = User.find_by_email(params[:email].downcase)

    if @user && @user.authenticate(params[:password])
      params[:remember] ? permanent_log_in(@user) : log_in(@user)
      flash[:success] = "Signed in successfully."
      redirect_to @user
    else
      flash[:error] = "Invalid information."
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = "Successfully signed out."
    redirect_to root_path
  end

  def show
    redirect_to login_path
  end
end
