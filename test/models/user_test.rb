require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do

    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do

    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do

  user = User.new
  assert !user.save
  assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = 'Joe'
    user.first_name = 'Joe'
    user.last_name = 'Grady'
    user.password = 'password'
    user.password_confirmation ='password'
    user.email = 'email@email.com'
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new
    user.profile_name = "My Profile With Spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'moe', last_name: 'Grady', email: 'eail@email.com')
    user.password = user.password_confirmation = 'asdfghjk'

    user.profile_name = 'joe'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:Joe).friends
    end
  end

  test "that creating frienships on a user works" do
    users(:Joe).pending_friends << users(:mike)
    users(:Joe).pending_friends.reload
    assert users(:Joe).pending_friends.include?(users(:mike))
  end

  test "that calling to_param on a user returns a profile_name" do
    assert_equal "Joe", users(:Joe).to_param
  end
end
