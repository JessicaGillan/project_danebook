module UsersHelper
  
  def sign_up_page_content
    {
      tagline:   "Connect with all your friends!",
      details: [ "See photos and updates in your news feed",
                 "Post your status for the world to see from your profile",
                 "Get in touch with your friends by \"friending\" them",
                 "Like things to make your friends feel validated" ]
    }
  end

  def sign_up_placeholders
    {
      first_name: "First Name",
      last_name: "Last Name",
      email: "Your Email",
      password: "Your New Password",
      password_confirmation: "Confirm Your Password"
    }
  end
end
