class UsersController < ApplicationController
  before_action      :require_current_user, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user,    only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      params[:remember] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "Welcome to the Danebook."

      redirect_to edit_user_profile_path(@user )
    else
      render :new
    end
  end

  def show
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :password, :password_confirmation,
                                 :birthday, :gender)
  end

  def require_current_user
    unless current_user.id == params[:id]
      flash[:danger] = "Sorry, you're not authorized for that."
      redirect_to :back
    end
  end
end
