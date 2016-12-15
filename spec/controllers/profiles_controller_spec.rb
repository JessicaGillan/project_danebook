require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  include ControllerExpectationMacros

  let(:profile) { create(:profile) }
  let(:user)    { profile.user }
  let(:other)   { create(:profile).user }

  # show
  context 'with authenticated user' do
    before do
      cookies[:auth_token] = user.auth_token
    end

    describe "GET #show" do
      it 'shows any users profile' do
        process :show, params: { user_id: other.id }

        expect_render
      end

      it 'gracefully fails if url user id isn\'t a user' do
        process :show, params: { user_id: 345 }

        expect_error
        expect_redirect
      end
    end
  end

  # show
  context 'with unauthenticated user' do
    describe "GET #show" do
      it 'indicates error and redirect to login path' do
        process :show, params: { user_id: user.id }

        expect_error
        expect_redirect( login_path )
      end
    end
  end

  # edit, update
  context 'with authorized user' do
    before do
      login(user)
    end

    describe 'GET #edit' do
      it 'delivers the edit form' do
        process :edit, params: { user_id: user.id }

        expect_render
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'updates the user\'s profile in the db' do
          process :update, params: { user_id: user.id,
          profile: { about_me: 'Beez.'} }
          user.reload

          expect(user.profile.about_me).to eq 'Beez.'
        end

        it 'indicates success and redirects' do
          process :update, params: { user_id: user.id,
          profile: { about_me: 'Beez.'} }

          expect_success
          expect_redirect( user_profile_path(user) )
        end
      end
    end
  end

  # edit, update
  context 'with unauthorized user' do
    describe 'GET #edit' do
      it 'indicates error and redirects' do
        process :edit, params: { user_id: user.id }

        expect_error
        expect_redirect
      end
    end

    describe 'PATCH #update' do
      it 'does not update the profile attempted' do
        before_update = user.profile
        process :update, params: { user_id: user.id,
                                   profile: { about_me: 'Beez.'} }
        user.reload

        expect(user.profile.about_me).to eq before_update.about_me
      end

      it 'indicates error and redirects' do
        process :update, params: { user_id: user.id,
                                   profile: { about_me: 'Beez.'} }

        expect_error
        expect_redirect
      end
    end

  end
end
