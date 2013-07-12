require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
        assert_redirected_to login_path
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:giann)
      end

      should "get new without error" do
        get :new
        assert_response :success
      end

      should "should set a flash error if the friend_id param is missing" do
        get :new, {}
        assert_equal "Friend required", flash[:error]
      end

        should "assign a new user friendship" do
        get :new, friend_id: users(:john)
        assert assigns(:user_friendship)
      end


        should "assign a new user friendship to the correct friend" do
        get :new, friend_id: users(:john)
        assert_equal users(:john), assigns(:user_friendship).friend
         end


       should "assign a new user friendship to the currently logged in user" do
        get :new, friend_id: users(:john)
        assert_equal users(:giann), assigns(:user_friendship).user
      end


      should "display a 404 page if no friend is found" do
        get :new, friend_id: 'invalid'
        assert_response :not_found
      end


      should "ask if you really want to friend the user" do
           get :new, friend_id: user(:john)
           assert_match /Do you really want to friend #{user(:john).full_name}?/, response.body
        end   

      should "display the friend's name" do
        get :new, friend_id: users(:john)
        assert_match /#{users(:john).full_name}/, response.body
      end

      should "assign a user friendship" do
        get :new, friend_id: users(:john).id
        assert assigns(:user_friendship)
      end

      should "assign a user friendship with the user as current user" do
        get :new, friend_id: users(:john).id
        assert_equal assigns(:user_friendship).user, users(:giann)
      end

      should "assign a user friendship with the correct friend" do
        get :new, friend_id: users(:john).id
        assert_equal assigns(:user_friendship).friend, users(:john)
      end
    end
  end
  
  context "#create" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
        assert_redirected_to login_path
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:giann)
      end

      context "with no friend_id" do
        setup do
          post :create
        end

        should "set the flash error message" do
          assert !flash[:error].empty?
        end

        should "set redirect to root" do
          assert_redirected_to root_path
        end
      end

      context "with a valid friend_id" do
        setup do
          post :create, friend_id: users(:brian).id
        end

        should "assign a friend object" do
          assert_equal users(:brian), assigns(:friend)
        end

        should "assign a user_friendship object" do
          assert assigns(:user_friendship)
          assert_equal users(:giann), assigns(:user_friendship).user
          assert_equal users(:brian), assigns(:user_friendship).friend
        end

        should "create a user friendship" do
          assert users(:giann).friends.include?(users(:brian))
        end
      end
    end
  end
end
