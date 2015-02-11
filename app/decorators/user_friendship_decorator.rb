class UserFriendshipDecorator < Draper::Decorator
  decorates :user_friendship

  def friendship_state
    model.state.titleize
  end

  def sub_message
    case model.state
    when 'pending'
      "Do you really want to be friends with #{model.friend.first_name}?"
    when 'accepted'
      "You are friends with #{model.friend.first_name}."
    end
  end
end
