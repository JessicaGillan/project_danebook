class UsersController < ApplicationController
  before_action      :set_user, only: [:show, :edit, :update, :destroy]

  before_action      :require_current_user, only: [:edit, :update, :destroy]

  skip_before_action :require_logged_in,  only: [:new, :create]
  before_action      :require_logged_out, only: [:create]

  def index
  end

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      params[:remember] ? permanent_log_in(@user) : log_in(@user)
      flash[:success] = "Welcome to the Danebook."

      redirect_to user_profile_path @user
    else
      flash.now[:danger] = "Denied! You need to enter better info to get on our site."
      render :new
    end
  end

  def show
  end

  def destroy
    @user.destroy
    log_out
    flash[:success] = "Congrats, you successfully destroyed yourself."
    redirect_to new_user_path
  end

  private

    def user_params
      params.require(:user).permit(
                                     :email,
                                     :password,
                                     :password_confirmation,
                                     { profile_attributes:
                                        [:id, :first_name,
                                         :last_name, :birthday,
                                         :gender ] }
                                   )
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_current_user
      unless current_user.id == params[:id]
        flash[:danger] = "Dude, you're not authorized for that."
        redirect_to :back
      end
    end

    def require_logged_out
      if user_logged_in?
        flash[:danger] = "You already have an account."
        store_location
        redirect_to current_user
      end
    end
end
