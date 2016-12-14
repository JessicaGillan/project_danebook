class LikesController < ApplicationController
  before_action :set_likable, only: [:create, :index, :destroy]

  # TODO: clean up repition, fix entire page reload on like???

  def create
    if @likable
      @likable.likes.build(liker_id: current_user.id )

      if @likable.save
        redirect_back(fallback_location: current_user )
      else
        flash[:error] = "Whoops, we didn't get that like saved. Try again."
        redirect_back(fallback_location: current_user )
      end
    else
      flash[:error] = "Whoops, we didn't get that like saved. Try again."
      redirect_back(fallback_location: current_user )
    end
  end

  def destroy
    @like = @likable.likes.find_by_liker_id( current_user.id )

    if @like.destroy
      redirect_back(fallback_location: current_user )
    else
      flash[:error] = "Whoops, we couldn't unlike that. Try again."
      redirect_back(fallback_location: current_user )
    end
  end

  private

    def set_likable
      @likable = extract_likable
    end

    def extract_likable
      params[:likable].classify.constantize.find_by_id( likable_id )
    end

    def likable_id
      case params[:likable]
      when "Post"    then params[:post_id]
      when "Comment" then params[:comment_id]
      else raise "Not a likable type."
      end
    end
end
