require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test" a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
end


	test"a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end


	test"a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end


	test"a user should have a unique profie name" do
		user = User.new
		user.profile_name = 'giannwilk'
		user.email = 'giannwilk@gmail.com'
		user.first_name = 'Giann'
		user.last_name = 'Wilkerson'
		user.password = 'password'
		user.password_confirmation ='password'
		assert !user.save
		puts user.errors.inspect
		assert !user.errors[:profile_name].empty?
	end

end