class ProfilesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @profile = @user.profile.build
  end

  def edit
  end
end
