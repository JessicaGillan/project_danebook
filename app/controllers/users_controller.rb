class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      params[:remember] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "Welcome to the Danebook, #{@user.username}."
      redirect to @user
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
