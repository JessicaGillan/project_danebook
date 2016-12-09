class ProfilesController < ApplicationController
  before_action      :set_user, only: [:show, :edit, :update, :destroy]

  def new
  end

  def create
  end

  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile.create
  end

  def update
    @profile = Profile.find( params[:id] )

    if @profile.update( profile_params )
      flash[:success] = "Profile updated!"
      redirect_to
    else

    end
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
