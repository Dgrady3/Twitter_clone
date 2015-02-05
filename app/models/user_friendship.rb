class UserFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  state_machine :state, initial: :pending do
    even :accept do
      transition any => :accepted
    end
  end

  def send_request_email
    UserNotifier.friend_requested(id).deliver
  end

  def send_acceptance_email
    UserNotifier.friend_request_accepted(id).deliver
  end
end
