class PhotosController < ApplicationController
  before_action :set_user
  before_action :set_photo, only: [:show, :destroy]
  before_action :require_friend, only: [:show]
  before_action :require_current_user, except: [:show, :index]

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
  end

  def destroy
    @photo.destroy
    flash[:success] = "Photo Deleted From Collection."
    redirect_to user_photos_path(@user)
  end

  private

    def set_photo
      @photo = Photo.find_by_id( params[:id] )
    end

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
        flash[:error] = "You need to be a friend to see that, silly goose."
        redirect_back(fallback_location: current_user )
      end
    end

    def require_current_user
      unless current_user.id == params[:user_id].to_i
        flash[:error] = "You're not authorized for that, silly."
        redirect_back(fallback_location: user_path(@user))
      end
    end
end
