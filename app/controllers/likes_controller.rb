class LikesController < ApplicationController

  def create
    
  end

  private

    def extract_likable
      params[:likable].classify.constantize.find( likable_id )
    end

    def likable_id
      case params[:likable]
      when "Post" then params[:post_id]
      else "id"
      end
    end
end
