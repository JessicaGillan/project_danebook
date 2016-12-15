require 'rails_helper'

feature 'Friends' do

  context 'a logged in user' do
    let(:profile)    { create(:profile) }
    let(:user)       { profile.user }
    let(:other_user) { create(:profile).user }

    before do
      login(user)
      visit user_path user
    end

    context 'with many friends' do
      let(:user_ids) { create_list(:profile, 25).pluck(:user_id) }

      scenario 'The "Friends" page for a user displays all of that User\'s Friends' do
        user.friended_users << user_ids.map{ |id| User.find_by_id(id) }
        names = user.friended_users.map(&:first_name)
        click_link "Friends"

        names.each do |name|
          expect(page).to have_content( name )
        end
      end

      # TODO: This test is not testing "random", how to test?
      # stub out rand_friends method ?
      scenario 'The "Friends" widget on the Timeline page displays the mini-thumbnails for a random selection of that User\'s friends' do
        user.friended_users << user_ids[0..5].map{ |id| User.find_by_id(id) }
        names = user.friended_users.map(&:name)

        visit user_path user

        names.each do |name|
          expect(page).to have_content( name )
        end
      end

    end

    scenario 'The "Friends" page fails gracefully if the User has no or few friends'
    scenario 'The "Friends" widget fails gracefully if the User has no or few friends'

    scenario 'Display the friend counts wherever appropriate.'
  end
end
