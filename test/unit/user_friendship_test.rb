require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works" do
    UserFriendship.create user: users(:giann), friend: users(:brian)
    assert users(:giann).friends.include?(users(:brian))
  end
end



test "that creating a friendship based on user id and friend id works" do
	UserFriendship.create user_id: users(:giann).id, friend_id: users(:brian).id
	assert users(:giann).friends.include?(users(:brian))

end