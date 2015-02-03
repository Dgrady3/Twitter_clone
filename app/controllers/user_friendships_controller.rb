class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]
  def new
    if params[:friend_id]
      @friend = User.find(params[:friend_id])
    else
      flash[:error] = "Friend required"
    end
  end
end
