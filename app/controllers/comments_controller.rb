class CommentsController < ApplicationController
  before_action :set_commentable,      only: [:create, :destroy]
  before_action :set_comment,          only: [:destroy]
  before_action :require_current_user, only: [:destroy]

  # TODO: clean up repition, fix entire page reload on like

  def create
    @comment = @commentable.comments.build( comment_params )
    @comment.author_id = current_user.id

    respond_to do |format|
      if @comment.save
        queue_comment_email( @comment )
        format.html { redirect_back(fallback_location: current_user ) }
        format.js   { }
      else
        flash[:error] = "Whoops, we didn't get that comment saved. Try again."
        format.html { redirect_back(fallback_location: current_user ) }
        format.js { head :none }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_back(fallback_location: current_user ) }
        format.js {}
      else
        flash[:error] = "Whoops, we couldn't uncomment that. Try again."
        format.html { redirect_back(fallback_location: current_user ) }
        format.js { head :none }
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_commentable
      @commentable = extract_commentable
      redirect_back(fallback_location: current_user ) unless @commentable
    end

    def set_comment
      @comment = @commentable.comments.find_by_id( params[:id] ) if @commentable
    end

    def extract_commentable
      params[:commentable].classify.constantize.find_by_id( commentable_id )
    end

    def commentable_id
      case params[:commentable]
      when "Post"  then params[:post_id]
      when "Photo" then params[:photo_id]
      else raise "Not a commentable type."
      end
    end

    def require_current_user
      if @comment
        unless current_user.id == @comment.author_id
          flash[:error] = "You're not authorized for that, silly rabbit."
          redirect_back(fallback_location: current_user )
        end
      end
    end

    # TODO: Can you check is_current_user? from model to make this a callback?
    def queue_comment_email( comment )
      user = comment.commentable.user

      UserMailer.delay.comment( user.id,  comment.id ) unless is_current_user?( user )
    end
end
