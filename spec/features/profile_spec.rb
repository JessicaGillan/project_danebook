require 'rails_helper'

feature 'Profile' do
  let(:profile) { create( :profile ) }

  before do
    login( profile.user )
  end

  scenario 'a logged in user can edit their profile' do
    click_link 'Edit Profile'

    expect(page).to have_content('Tell us about yourself')
  end

  scenario 'new profile data is displayed after editing' do
    click_link 'Edit Profile'

    fill_in 'About me', with: "I have llamas."

    click_button 'Update Profile'

    expect(page).to have_css 'div.alert-success'
    expect(page).to have_content 'I have llamas.'
  end

  scenario 'there is not a link to edit another user\'s profile' do
    other_user = create(:profile).user

    visit user_path( other_user )

    expect(page).not_to have_content 'Edit Profile'
  end
end
