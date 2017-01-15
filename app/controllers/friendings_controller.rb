class FriendingsController < ApplicationController

  def index
    @user = User.find_by_id( params[:id] )

    @friends = @user.friended_users + @user.users_friended_by if @user
  end

  def create
    friending_recipient = User.find_by_id( params[:id] )

    if current_user.friended_users << friending_recipient
      flash[:success] = "Friended #{friending_recipient.first_name}"
      redirect_back(fallback_location: friending_recipient )
    else
      flash[:error] = "Sad day. Couldn't friend #{friending_recipient.first_name}"
      redirect_back(fallback_location: current_user )
    end
  end

  def destroy
    unfriended_user = User.find_by_id( params[:id] )

    current_user.friended_users.delete( unfriended_user )
    flash[:success] = "Unfriended #{unfriended_user.first_name}"
    redirect_to unfriended_user
  end
end
