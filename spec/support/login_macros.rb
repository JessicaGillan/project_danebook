module LoginMacros
  def login(user)
    visit root_path

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log In'
  end
end
