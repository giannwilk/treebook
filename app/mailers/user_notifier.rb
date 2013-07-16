class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def friend_requested(user_friendship_id)
  	user_friendship = UserFriendship.find(user_friendship_id)

  	@user = user_friendship.user
  	@friend = user_friendship.friend


  	mail to: @friend.email,
  	subject: "#{@user.first_name} wantes to be friends on DevBook"

  end
end
