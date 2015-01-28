require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do

    user = User.new
    assert !user.save
  end
end
