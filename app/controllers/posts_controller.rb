class PostsController < ApplicationController
  before_action      :require_current_user, only: [:new, :create, :edit, :update, :destroy]

  def create
    @post = current_user.posts.build( post_params )

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_path current_user}
        format.js   { }
      else
        flash[:error] = "Couldn't create post. #{@post.errors.full_messages.join(", ")}"

        format.html { redirect_to user_path current_user }

        format.js { }
      end
    end
  end

  def edit
    @post = @user.posts.find_by_id( params[:id] ) if @user
  end

  def update
    @post = current_user.posts.find_by_id( params[:id] )
    if @post.update( post_params )
      flash[:success] = "Post Updated"
      redirect_to user_path @user
    else
      flash[:danger] = "Couldn't update post."
      redirect_to user_path @user
    end
  end

  def destroy
    @post = current_user.posts.find_by_id( params[:id] )

    respond_to do |format|
      if @post.destroy
        flash[:success] = "Post Deleted"
        format.html { redirect_to user_path current_user }
        format.js {}
      else
        flash[:danger] = "Couldn't delete post."
        format.html { redirect_to user_path current_user }
        format.js { head :none }
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

    def require_current_user
      unless current_user.id == params[:user_id].to_i
        flash[:danger] = "Dude, you're not authorized for that."
        redirect_to :back
      end
    end
end
