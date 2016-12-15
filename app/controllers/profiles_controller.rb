class ProfilesController < ApplicationController
  before_action  :set_user, only: [:show, :edit, :update, :destroy]
  before_action  :require_current_user, except: [:show]
  # def new
  # end
  #
  # def create
  # end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile

    if @profile.update( profile_params )
      flash[:success] = "Profile updated!"
      redirect_to user_profile_path @user
    else

    end
  end

  def show
    if @user.nil?
      flash[:error] = "That user doesn't exist."
      redirect_to user_profile_path current_user
    elsif @user.profile.nil?
      flash[:error] = "That user hasn't set up a profile yet."
      redirect_to user_profile_path current_user
    end
  end

  private
    # TODO: ADD ability to update ALL profile attributes:
    # first_name, last_name
    def profile_params
      params.require(:profile).permit(:birthday, :college,
                                      :hometown, :current_location,
                                      :phone, :tagline, :about_me)
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def require_current_user
      unless current_user.id == params[:user_id].to_i
        flash[:error] = "Dude, you're not authorized for that."
        redirect_to :back
      end
    end
end
