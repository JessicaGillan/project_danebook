module ApplicationHelper

  def navbar
    if user_logged_in?
      'shared/logged_in_nav'
    else
      'shared/logged_out_nav'
    end
  end
end
