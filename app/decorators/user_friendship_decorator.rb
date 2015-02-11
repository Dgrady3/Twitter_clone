class UserFriendshipDecorator < Draper::Decorator
  decorates :user_friendship

  def friendship_state
    "Pending"
  end
end
