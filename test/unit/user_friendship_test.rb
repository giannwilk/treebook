require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exeption" do
  	assert_nothing_raised do
    UserFriendship.create user: users(:giann), friend: users(:brian)
  end
end

test "that creating a friendship based on user id and friend id works" do
	UserFriendship.create user_id: users(:giann).id, friend_id: users(:brian).id
	assert users(:giann).friends.include?(users(:brian))
end


  context "a new instance" do
  	setup do
  	  @user_friendship = UserFriendship.new user: users(:giann), friend: users(:brian)
  	end


  	should "have a pending state" do
  		assert_equal 'pending', @user_friendship.state
  	end
  end


  context "#send_request_email" do
  	setup do 
  	  @user_friendship = UserFriendship.create user: users(:giann), friend: users(:brian)
     end


   should "send an email" do
    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
     @user_friendship.send_request_email
   end
  end
 end
end