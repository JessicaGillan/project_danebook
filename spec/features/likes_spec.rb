require 'rails_helper'

feature 'Likes' do
  let(:profile)    { create(:profile) }
  let(:user)       { profile.user }
  let(:post)       { user.posts.create(body: "I'm eating.") }
  let(:comment)    { post.comments.create(body: "Grool.", author_id: user.id) }
  let(:other_user) { create(:profile).user }

  before do
    login(user)
    post
    comment
    visit user_path user
  end

  context 'a logged in user' do
    scenario 'can like posts once' do
      expect{ find(:xpath, "//a[@href='/posts/#{post.id}/likes']").click }
            .to change(post.likes, :count).by(1)

      expect(page).not_to have_xpath("//a[@href='/posts/#{post.id}/likes']")
    end

    scenario 'can like comments once' do
      expect{ find(:xpath, "//a[@href='/comments/#{comment.id}/likes']").click }
            .to change(comment.likes, :count).by(1)

      expect(page).not_to have_xpath("//a[@href='/comments/#{comment.id}/likes']")
    end
    
    scenario 'can unlike posts'
    scenario 'can unlike comments'
  end

  context 'comments and posts' do
    scenario 'with one like'
    scenario 'with two likes'
    scenario 'with many likes'

    context 'with the current user as a liker' do
      scenario 'with one like'
      scenario 'with two likes'
      scenario 'with many likes'
    end
  end

end
