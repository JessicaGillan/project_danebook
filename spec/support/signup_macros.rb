module SignupMacros
  def sign_up(user, profile)
    visit root_path
    
    profile.user = user

    fill_in 'user[profile_attributes][first_name]', with: user.profile.first_name
    fill_in 'user[profile_attributes][last_name]', with: user.profile.last_name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password

    select 'March', :from => 'user[profile_attributes][birthday(2i)]'
    select '13',    :from => 'user[profile_attributes][birthday(3i)]'
    select '2000',  :from => 'user[profile_attributes][birthday(1i)]'

    choose 'Female'

    click_button 'Create User'
  end
end
