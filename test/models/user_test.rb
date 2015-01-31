require 'test_helper'

class UserTest < ActiveSupport::TestCase
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
    user = User.new(first_name: 'Joe', last_name: 'Grady', email: 'email@email.com')
    user.password = user.password_confirmation = 'asdfghjk'

    user.profile_name = 'joe_1'
    assert user.valid?
  end
end
