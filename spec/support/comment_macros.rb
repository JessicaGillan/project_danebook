module CommentMacros
  def comment( text )
    fill_in 'create-comment', with: text
    click_button 'Comment'
  end
end
