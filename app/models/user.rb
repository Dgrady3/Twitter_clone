class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :statuses

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def full_name
    first_name + " " + last_name
  end
end
