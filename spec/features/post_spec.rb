require 'rails_helper'

feature 'Post' do
  let(:profile) { create( :profile ) }
  let(:user) { profile.user }
  let(:other_user) { create( :profile ).user }


  before do
    login( user )
  end

  scenario 'a logged in user can post on their own timeline' do
    visit user_path user

    fill_in 'post[body]', with: "I like Gouda."

    click_button 'Post'

    expect(page).to have_content 'I like Gouda.'
  end

  scenario 'a logged in user cannot post a blank post' do
    visit user_path user

    fill_in 'post[body]', with: ""

    click_button 'Post'

    expect(page).to have_css 'div.alert-error'
  end

  scenario 'a logged in user cannot post on other people\'s timelines' do
    visit user_path other_user

    expect(page).not_to have_css 'textarea#post_body'
  end

  scenario 'a logged in user can delete their post' do
    post(user, "Posty post text")

    post_id = user.posts.first.id

    save_and_open_page
    find(:xpath, "//a[@href='/users/#{user.id}/posts/#{post_id}']").click

    expect(page).not_to have_content 'Posty post text'
  end

  scenario 'a logged in user cannot delete other people\'s posts' do
    other_user.posts.create(body: "Other User Post Body")

    visit user_path other_user

    expect(page).to have_content 'Other User Post Body'
    expect(page).not_to have_content 'Delete'
  end
end
