require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include ControllerExpectationMacros

  let(:user){ create(:user) }

  context 'for a logged in user' do
    before do
      login(user)
    end

    describe "DELETE #destroy" do
      it "logs the user out" do
        process :destroy

        expect(cookies[:auth_token]).to be_nil
      end

      it "flashes success and redirects" do
        process :destroy

        expect_success
        expect_redirect( root_path )
      end
    end
  end

  context 'for a logged out user' do
    describe "DELETE #destroy" do
      it 'will redirect the user' do
        process :destroy

        expect_error
        expect_redirect
      end
    end

    describe 'GET #new' do
      it 'renders login form' do
        process :new

        expect_render
      end
    end

    describe 'POST #create' do
      context 'with correct log in info' do
        it 'logs the user in' do
          user
          process :create, params: { email: user.email, password: user.password }
          user.reload

          expect(cookies[:auth_token]).to eq user.auth_token
        end

        it 'indicates success and redirects the user' do
          user
          process :create, params: { email: user.email, password: user.password }

          expect_success
          expect_redirect
        end
      end

      context 'with incorrect login info' do
        it 'will indicate error and re-render' do
          user
          process :create, params: { email: user.email, password: "notright" }

          expect_error
          expect_render
        end
      end
    end
  end

end
