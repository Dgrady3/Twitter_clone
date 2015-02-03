class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, uniqueness: true, format: { with: /^[a-zA-Z0-9-]+$/, multiline: true, message: "Must be formatted correctly." }

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end
