class UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      params[:remember] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "Welcome to the Danebook."
      redirect_to @user
    else
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
