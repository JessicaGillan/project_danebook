require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  include ControllerExpectationMacros

  let(:user)    { create(:user) }
  let(:post)    { user.posts.create(body: "Herro") }
  let(:comment) { post.comments.create(body: "Good post", author_id: user.id) }

  before do
    cookies[:auth_token] = user.auth_token
  end

  describe 'POST #create' do
    it 'can add a like to a post' do
      expect do
        process :create, params: { post_id: post.id, likable: 'Post'}
      end.to change(post.likes, :count).by 1
    end

    it 'can add a like to a comment' do
      expect do
        process :create, params: { comment_id: comment.id, likable: 'Comment'}
      end.to change(comment.likes, :count).by 1
    end

    it 'sets the current_user as the liker' do
      process :create, params: { comment_id: comment.id, likable: 'Comment'}

      expect( comment.likes.pluck(:liker_id) ).to include(user.id)
    end
  end

  describe 'DELETE #destroy' do
    it 'can remove the current_user\'s like on a post' do
      like = post.likes.create(liker_id: user.id)

      expect{
        process :destroy, params: { post_id: post.id, id: like.id, likable: 'Post' }
      }.to change(post.likes, :count).by -1
    end

    it 'can remove the current_user\'s like on a comment' do
      like = comment.likes.create(liker_id: user.id)

      expect{
        process :destroy, params: { comment_id: comment.id, id: like.id, likable: 'Comment' }
      }.to change(comment.likes, :count).by -1
    end

    it 'indicates an error and redirects if there\'s not a like to delete' do
      process :destroy, params: { comment_id: comment.id, id: 5, likable: 'Comment' }

      expect_error
      expect_redirect
    end
  end
end
