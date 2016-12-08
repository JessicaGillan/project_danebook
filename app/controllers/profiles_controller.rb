class ProfilesController < ApplicationController
  def new
  end

  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end

  def update
    @profile = Profile.find( params[:id] )

    if @profile.update( profile_params )
      flash[:success] = "Profile updated!"
      redirect_to 
    else

    end
  end
end
