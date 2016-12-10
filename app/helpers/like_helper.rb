module LikeHelper

  def list_of_likes( object )
    likes = object.likes
    unless likes.empty?
      first_liker = likes.first.liker

      if likes.count == 1
        if first_liker == current_user
          "You like this."
        else
          (link_to "#{first_liker.profile.first_name} #{first_liker.profile.last_name}",
                   user_profile_path( first_liker )).html_safe + " likes this."
        end
      else
        (you( likes.pluck(:liker_id) ) + likers( likes, first_liker )).html_safe
      end
    end
  end

  def you( ids )
    return "You " if ids.include? current_user.id
    ""
  end

  def likers( likes, first_liker )
    if likes.count == 2
        "and " + (link_to "#{first_liker.profile.first_name} #{first_liker.profile.last_name}",
               user_profile_path( first_liker )).html_safe + " like this."
    else
      "and #{likes.count} others like this."
    end
  end
end
