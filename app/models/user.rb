class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, uniqueness: true, format: { with: /^[a-zA-Z0-9-]+$/, multiline: true, message: "Must be formatted correctly." }

  has_many :statuses
  has_many :user_friendships
  has_many :friends, -> { where(user_friendships: { state: 'accepted' }) },
                          through: :user_friendships

  has_many :pending_user_friendships, ->  { where class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'pending' } }

  has_many :pending_friends, -> { where  :pending_user_friendships}, source: :friend

  has_many :requested_user_friendships, -> { where class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'requested' } }

  has_many :requested_friends, -> { where  :pending_user_friendships }, source: :friend
  has_many :blocked_user_friendships, -> { where class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'blocked' } }

  has_many :blocked_friends, -> { where  :pending_user_friendships }, source: :friend

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_param
    profile_name
  end
end
