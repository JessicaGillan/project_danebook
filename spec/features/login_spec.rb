require 'rails_helper'

feature 'Login' do
  let(:user) { create( :user ) }
  let(:profile) { create( :profile ) }

  before do
    visit root_path
    profile.user = user
    user.save
  end

  scenario 'a logged out user can sign in' do
    login(user)

    expect(page).to have_content('Timeline')
    expect(page).to have_content(user.first_name)
  end

  scenario 'a logged in user can log out' do
    login(user)

    click_link 'Log Out'

    # This doesn't work, another way to do it?
    # expect(page).to redirect_to(root_path)

    expect(page).to have_content 'Successfully signed out.'
  end
end
