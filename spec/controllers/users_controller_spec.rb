require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include ControllerExpectationMacros

  let(:user) { create(:user) }
  let(:another ) { create(:user) }

  # show, index / new, create
  context 'with authenticated user' do
    before do
      cookies[:auth_token] = user.auth_token
    end

    describe "GET #new" do
      it "redirects to that user" do
        process :new

        expect(response).to redirect_to user
        expect(flash[:error]).not_to be_nil
      end
    end

    describe "POST #create" do
      it "redirects to that user" do
        process :create

        expect(response).to redirect_to user
        expect(flash[:error]).not_to be_nil
      end
    end

    describe "GET #show" do
      it "shows any users timeline" do
        process :show, params: { id: another.id}

        assert_response :success

        process :show, params: { id: user.id}

        assert_response :success
      end
    end

    describe "GET #index" do
      it "shows a list of users" do
        process :index

        assert_response :success
      end
    end
  end

  # new, create / show, index
  context 'with unauthenticated user' do
    describe "GET #new" do
      it "returns the sign up page" do
        process :new

        assert_response :success
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new user" do
          expect do
            process :create, params: { user: attributes_for(:user) }
          end.to change(User, :count).by 1
        end

        it "redirects to the new users page" do
          process :create, params: { user: attributes_for(:user) }

          expect(response).to redirect_to user_profile_path(User.last)
          expect(flash[:success]).not_to be_nil
        end

        it "logs the user in" do
          process :create, params: { user: attributes_for(:user) }

          expect(cookies[:auth_token]).to eq(User.last.auth_token)
        end
      end

      context "with invalid attributes" do
        it "does not create a new user" do
          expect do
            process :create, params: { user: attributes_for(:user, email: '') }
          end.not_to change(User, :count)
        end

        it "stays on the new page" do
          process :create, params: { user: attributes_for(:user, email: '') }

          assert_response :ok # Does not redirect
          expect(flash[:error]).not_to be_nil
        end
      end

    end

    describe "GET #show" do
      it 'does not show user' do
        process :show, params: { id: user.id }

        expect(response).to redirect_to login_path
        expect(flash[:error]).not_to be_nil
      end
    end

    describe "GET #index" do
      it 'does not show users' do
        process :index

        expect(response).to redirect_to login_path
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  # edit, update, destroy
  context 'with authorized user' do
    before do
      cookies[:auth_token] = user.auth_token
    end

    describe 'GET #edit'

    describe 'PATCH #update'

    describe 'DELETE #destroy' do
      it 'destroys the user' do
        expect do
          process :destroy, params: { id: user.id }
        end.to change(User, :count).by -1
      end

      it 'logs the user out' do
        process :destroy, params: { id: user.id }

        expect( cookies[:auth_token] ).to be_nil
      end
    end
  end

  # edit, update, destroy
  context 'with unauthorized user' do
    describe 'GET #edit'

    describe 'PATCH #update'

    describe 'DELETE #destroy' do
      it 'does not destroy the user' do
        user

        expect do
          process :destroy, params: { id: user.id }
        end.not_to change(User, :count)
      end

      it 'will redirect the user' do
        process :destroy, params: { id: user.id }

        assert_response :redirect
      end
    end
  end
end
