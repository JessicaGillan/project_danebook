class PhotosController < ApplicationController
  before_action :set_user

  def index
    @photos = @user.photos.map(&:photo) if @user
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

  private

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def photo_params
      params.require(:photo).permit(:photo)
    end
end
