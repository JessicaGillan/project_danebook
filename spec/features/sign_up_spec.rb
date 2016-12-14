require 'rails_helper'

feature 'Sign up' do
  let(:user) { build( :user ) }
  let(:profile) { create( :profile ) }

  before do
    visit root_path
  end

  scenario 'for a logged out user, the root path goes to a sign up form' do
    expect(page).to have_content 'Sign Up!'
  end

  scenario 'a new user can sign up with basic info' do
    sign_up( user, profile )

    expect(page).to have_content user.profile.first_name
    expect(page).to have_content user.profile.last_name
    expect(page).to have_content user.email
    expect(page).to have_content '2000-03-13'
  end

  scenario 'bad information keeps a new user on the sign up page' do
    click_button 'Create User'

    expect(page).to have_css 'div.alert-error'
    expect(page).to have_content 'Sign Up!'
  end

  scenario 'a logged in user cannot sign up as a new user' do
    user.save
    profile.user = user
    profile.save

    login(user)

    sign_up(user, profile)

    expect(page).to have_css 'div.alert-error'
  end
end
