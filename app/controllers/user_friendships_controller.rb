class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_friendships = current_user.user_friendships.all
  end

  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.accept!
      flash[:success] = "You are now friends with #{@user_friendship.friend.first_name}"
    else
      flash[:error] = "That friendship can not be accepted"
      redirect_to user_friendships_path
    end
  end

  def new
    if params[:friend_id]
      @friend = User.where(profile_name: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "Friend required"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
      @user_friendship = UserFriendship.request(current_user, @friend)
      respond_to do |format|
        if @user_friendship.new_record?
          format.html do
            flash[:error] = "There was problem creating that friend request."
            redirect_to profile_path(@friend)
          end
          format.json { render json: @user_friendship.to_json, status: :precondition_failed }
        else
          format.html do
            flash[:success] = "Friend request sent."
            redirect_to profile_path(@friend)
          end
          format.json { render json: @user_friendship.to_json }
        end
      end
    else
      flash[:error] = "Friend required"
      redirect_to root_path
    end
  end

  def edit
    @user_friendship = current_user.user_friendships.find(params[:id])
    @friend = @user_friendship.friend
  end

  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.destroy
      flash[:success] = "Friendship has been destroyed"
    redirect_to user_friendships_path
  end
end
