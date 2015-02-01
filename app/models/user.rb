class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, format: { with: /^[a-zA-Z0-9-]+$/, multiline: true, message: "must be formatted correctly." }

  has_many :statuses


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end
