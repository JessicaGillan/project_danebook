class FriendingsController < ApplicationController

  def index
    @user = User.find_by_id( params[:id] )

    @friends = @user.friended_users + @user.users_friended_by if @user
  end

  def create
    friending_recipient = User.find_by_id( params[:id] )

    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.profile.first_name}"
      redirect_to friending_recipient
    else
      flash[:error] = "Sad day. Couldn't friend #{friending_recipient.profile.first_name}"
      redirect_to friending_recipient
    end
  end

  def destroy
    unfriended_user = User.find_by_id( params[:id] )

    current_user.friended_users.delete( unfriended_user )
    flash[:success] = "Successfully unfriended that neanderthal."
    redirect_to unfriended_user
  end
end
