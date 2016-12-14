class PostsController < ApplicationController
  before_action      :set_user
  before_action      :require_current_user, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @post = @user.posts.build if @user
  end

  def create
    if @user
      @user.posts.build( post_params )
      if @user.save
        flash[:success] = "Post Created"
        redirect_to user_path @user
      else
        flash[:error] = "Couldn't create post."
        redirect_to user_path @user
      end
    else
      flash[:error] = "Sorry that user doesn't exist."
      redirect_to user_path current_user
    end
  end

  def edit
    @post = @user.posts.find_by_id( params[:id] ) if @user
  end

  def update
    if @user
      @post = @user.posts.find_by_id( params[:id] )
      if @post.update( post_params )
        flash[:success] = "Post Updated"
        redirect_to user_path @user
      else
        flash[:danger] = "Couldn't update post."
        redirect_to user_path @user
      end
    else
      flash[:danger] = "Sorry that user doesn't exist."
      redirect_to user_path current_user
    end
  end

  def destroy
    if @user
      @post = @user.posts.find_by_id( params[:id] )
      if @post.destroy
        flash[:success] = "Post Deleted"
        redirect_to user_path @user
      else
        flash[:danger] = "Couldn't delete post."
        redirect_to user_path @user
      end
    else
      flash[:danger] = "Sorry that user doesn't exist."
      redirect_to user_path current_user
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def require_current_user
      unless current_user.id == params[:user_id].to_i
        flash[:danger] = "Dude, you're not authorized for that."
        redirect_to :back
      end
    end
end
