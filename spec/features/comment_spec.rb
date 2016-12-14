require 'rails_helper'

feature 'Comment' do
  let(:profile) { create( :profile ) }
  let(:user) { profile.user }


  before do
    login( user )
    post(user)
  end

  scenario 'a logged in user can comment on posts' do
    comment 'Word.'

    expect(page).to have_content 'Word.'
  end

  scenario 'a logged in user cannot post a blank comment' do
    comment ''

    expect(page).to have_css 'div.alert-error'
  end

  scenario 'a logged in user can delete their comment' do
    comment 'Word.'

    post_id = user.posts.first.id
    comment_id = user.posts.first.comments.first.id

    find(:xpath, "//a[@href='/posts/#{post_id}/comments/#{comment_id}']").click

    expect(page).not_to have_content 'Word.'
  end

  scenario 'a logged in user cannot delete other people\'s comments' do
    other_user = create(:profile).user
    post = other_user.posts.create(body: "Other User Post Body")
    post.comments.create(body: "Other word.", author_id: other_user.id )

    visit user_path other_user

    expect(page).to have_content 'Other User Post Body'
    expect(page).to have_content 'Other word.'

    expect(page).not_to have_content 'Delete'
  end

end
