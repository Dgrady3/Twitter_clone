class UserFriendshipDecorator < Draper::Decorator
  decorates :user_friendship
  delegate_all

  def friendship_state
    model.state.titleize
  end

  def sub_message
    case model.state
    when 'pending'
      "Friend request pending."
    when 'accepted'
      "You are friends with #{model.friend.first_name}."
    end
  end
end
