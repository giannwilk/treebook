class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
    if params[:friend_id]
      @friend = User.find(params[:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "Friend required"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:friend_id]
      @friend = User.find(params[:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
      if @user_friendship.save
        flash[:success] = "Friendship created."
      else
        flash[:error] = "There was a problem."
      end
      redirect_to profile_path(@friend)
    else
      flash[:error] = "Friend required"
      redirect_to root_path
    end
  end
end
