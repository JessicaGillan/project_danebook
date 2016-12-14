module PostMacros
  def post(user, text = "I like Gouda.")
    visit user_path user

    fill_in 'post[body]', with: text

    click_button 'Post'
  end
end
