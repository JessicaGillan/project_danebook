class UserMailer < ApplicationMailer
  default from: "TheDanes@book.com", subject: "Welcome"

  def welcome( id )
    @user = User.find_by_id( id )

    mail( to: @user.email ).deliver
  end

  def comment( user_id, comment_id )
    @user = User.find_by_id( user_id )
    @comment = Comment.find_by_id( comment_id )

    @commentable = @comment.commentable

    mail( to: @user.email ).deliver
  end
end
