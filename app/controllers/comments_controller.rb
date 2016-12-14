class CommentsController < ApplicationController
  before_action :set_commentable,      only: [:create, :index, :destroy]
  before_action :set_comment,          only: [:destroy]
  before_action :require_current_user, only: [:destroy]

  # TODO: clean up repition, fix entire page reload on like???

  def index
  end

  def create
    if @commentable
      @comment = @commentable.comments.build( comment_params )
      @comment.author_id = current_user.id

      if @comment.save
        redirect_back(fallback_location: current_user )
      else
        flash[:error] = "Whoops, we didn't get that comment saved. Try again."
        redirect_back(fallback_location: current_user )
      end
    else
      flash[:error] = "Whoops, we didn't get that comment saved. Try again."
      redirect_back(fallback_location: current_user )
    end
  end

  def destroy
    if @comment.destroy
      redirect_back(fallback_location: current_user )
    else
      flash[:error] = "Whoops, we couldn't uncomment that. Try again."
      redirect_back(fallback_location: current_user )
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_commentable
      @commentable = extract_commentable
    end

    def set_comment
      @comment = @commentable.comments.find_by_id( params[:id] ) if @commentable
    end

    def extract_commentable
      params[:commentable].classify.constantize.find_by_id( commentable_id )
    end

    def commentable_id
      case params[:commentable]
      when "Post" then params[:post_id]
      else raise "Not a commentable type."
      end
    end

    def require_current_user
      if @comment
        unless current_user.id == @comment.author_id
          flash[:danger] = "Dude, you're not authorized for that."
          redirect_back(fallback_location: current_user )
        end
      end
    end
end
