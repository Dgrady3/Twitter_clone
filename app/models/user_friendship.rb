class UserFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  state_machine :state, initial: :pending do
    after_transition on: :accept, do: [:send_acceptance_email]

    state :requested

    event :accept do
      transition any => :accepted
    end
  end

  def self.request(user1, user2)
    transaction do
      friendship1 = create(user: user1, friend: user2, state: 'pending')
      friendship2 = create(user: user2, friend: user1, state: 'requested')

      friendship1.accept_mutual_friendship!
      friendship2.reload
      assert_equal 'accepted', friendship2.state
    end
  end

  def send_request_email
    UserNotifier.friend_requested(id).deliver
  end

  def send_acceptance_email
    UserNotifier.friend_request_accepted(id).deliver
  end

  def accept_mutual_friendship!
    mutual_friendship = self.class.where({user_id: friend_id, friend_id: user_id}).first
    mutual_friendship.update_attribute(:state, 'accepted')
  end
end
