class UserMailer < ApplicationMailer
  default from: "foo@bar.com", subject: "Welcome"

  def welcome( id )
    @user = User.find_by_id( id )

    mail( to: @user.email ).deliver
  end
end
