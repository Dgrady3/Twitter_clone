require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works"  do
    assert_nothing_raised do
      UserFriendship.create user: users(:Joe), friend: users(:mike)
    end
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:Joe).id, friend_id: users(:jim).id
    assert users(:Joe).pending_friends.include?(users(:jim))
  end

  context "a new instance " do
    setup do
      @user_friendship = UserFriendship.new user: users(:Joe), friend: users(:jim)
    end

    should "have a pending state" do
      assert_equal 'pending', @user_friendship.state
    end
  end

  context "#send_request_email" do
    setup do
      @user_friendship = UserFriendship.create user: users(:Joe), friend: users(:jim)
    end

    should "send an email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.send_request_email
      end
    end
  end

  context "#accet!" do
    setup do
      @user_friendship = UserFriendship.create user: users(:Joe), friend: users(:jim)
    end

    should "set the state to accepted" do
      @user_friendship.accept!
      assert_equal "accepted", @user_friendship.state
    end

    should "send an acceptance email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.accept!
      end
    end

    should "include the friend in the list of friends" do
      @user_friendship.accept!
      users(:Joe).friends.reload
      assert users(:Joe).friends.include?(users(:jim))
    end
  end
end
