class PhotosController < ApplicationController
  before_action :set_user
  before_action :require_friend, only: [:show]

  def index
    @photos = @user.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    @user.photos.build( photo_params )

    if @user.save
      flash[:success] = "Photo Uploaded."

      redirect_to user_photos_path @user
    else
      flash.now[:error] = "We couldn't create an account with that info."
      redirect_back(fallback_location: user_photos_path(@user) )
    end
  end

  def show
    @photo = Photo.find_by_id( params[:id] )
  end

  private

    def set_user
      # TODO redirect if don't find user
      @user = User.find_by_id(params[:user_id])
    end

    def photo_params
      # TODO fix so doesn't break when user hits button w/o adding file
      params.require(:photo).permit(:user_photo)
    end

    def require_friend
      unless (@user.friends.include? current_user) || @user.id == current_user.id
        raise
        flash[:error] = "You need to be a friend to see that, silly goose."
        redirect_back(fallback_location: current_user )
      end
    end
end
