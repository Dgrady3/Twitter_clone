require 'test_helper'

class AddAFriendTest < ActionDispatch::IntegrationTest

    get "/user_friendships/new?friend_id=#{users(:jim).profile_name}"
    assert_response :success

    asser_different 'UserFriendship.count' do
      post "/user_friendships", user_friendship: { friend_id: users(:Joe).profile_name }
      assert_response :redirect
      assert_equal "You are now friends with #{user(:jim).full_name}", flash[:success]
  end
end
