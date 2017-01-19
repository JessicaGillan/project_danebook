module LikeHelper

  def list_of_likes(object)
    likes = object.likes
    return if likes.empty?
    
    first_liker = likes.first.liker
    first_liker_link = (link_to "#{first_liker.profile.first_name} #{first_liker.profile.last_name} ",
             user_path( first_liker )).html_safe

    if likes.count == 1
      if first_liker == current_user
        "You like this."
      else
        first_liker_link + " likes this."
      end
    elsif you_str = you(likes.pluck(:liker_id))
      (you_str + likers( likes, first_liker )).html_safe
    else
      (first_liker_link + likers( likes, likes[1].liker )).html_safe
    end
  end

  def you(ids)
    return "You " if ids.include? current_user.id
    false
  end

  def likers(likes, liker)
    "and #{pluralize(likes.count - 1, 'other')} like this."
  end
end
