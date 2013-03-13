require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:statuses)
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
    user.profile_name = users(:giann).profile_name
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'giann', last_name: 'wilkerson', email: 'giannwilk@gmail.com')
    user.profile_name = 'giannwilk'
    user.password = user.password_confirmation = 'ashforce'

    user.profile_name = 'Contains spaces'

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end 
   

  test "a user should have a profile name" do
    user = User.new(first_name: 'Giann', last_name: 'Wilkerson', email: 'giannwilk@gmail.com')
    user.password = user.password_confirmation = 'ashforce'

    user.profile_name = 'giannwilk_1'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:giann).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:giann).friends << users(:brian)
    users(:giann).friends.reload
    assert users(:giann).friends.include?(users(:brian))
  end
end
