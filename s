[1mdiff --git a/app/models/user.rb b/app/models/user.rb[m
[1mindex 2c93317..e5abc97 100644[m
[1m--- a/app/models/user.rb[m
[1m+++ b/app/models/user.rb[m
[36m@@ -28,6 +28,14 @@[m [mclass User < ActiveRecord::Base[m
     first_name + " " + last_name[m
   end[m
 [m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32mdef to_param[m
[32m+[m[32m     profile_name[m
[32m+[m[32m  end[m
[32m+[m[41m  [m
[32m+[m[32mend[m
   def gravatar_url[m
     stripped_email = email.strip[m
     downcased_email = stripped_email.downcase[m
[1mdiff --git a/app/views/statuses/index.html.erb b/app/views/statuses/index.html.erb[m
[1mindex 1b85d15..011cab7 100644[m
[1m--- a/app/views/statuses/index.html.erb[m
[1m+++ b/app/views/statuses/index.html.erb[m
[36m@@ -8,7 +8,7 @@[m
 <div class="status">[m
   <div class="row">[m
     <div class="span1">[m
[31m-      <%= image_tag status.user.gravatar_url %>[m
[32m+[m[32m      <%= link_to image_tag(status.user.gravatar_url),profile_path(status.user) %>[m
     </div>[m
     <div class="span7">[m
       <strong><%= status.user.full_name %></strong>[m
[1mdiff --git a/app/views/user_friendships/new.html.erb b/app/views/user_friendships/new.html.erb[m
[1mindex ca11cba..0e6a2cb 100644[m
[1m--- a/app/views/user_friendships/new.html.erb[m
[1m+++ b/app/views/user_friendships/new.html.erb[m
[36m@@ -1,3 +1,23 @@[m
[32m+[m[32m<% if @friend %>[m[41m[m
[32m+[m[41m[m
[32m+[m[32m<h1><%= @friend.full_name %></h1>[m[41m[m
[32m+[m[41m[m
[32m+[m[32m<p>Do you really want to friend <%= @friend.full_name %>?</p>[m[41m[m
[32m+[m[41m[m
[32m+[m[32m<%= form_for @user_friendship,method: :post do |form| %>[m[41m[m
[32m+[m[32m     <div class="form from-actions">[m[41m[m
[32m+[m[41m     [m	[32m<%= submit_tag "Yes, Add Friend", class: 'btn btn-primary' %>[m[41m[m
[32m+[m[41m[m
[32m+[m[32m     </div>[m[41m[m
[32m+[m[41m[m
[32m+[m[32m     <% end %>[m[41m[m
[32m+[m[32m    <% end %>[m[41m [m
[32m+[m[41m[m
[32m+[m[41m[m
[32m+[m[41m[m
[32m+[m[41m[m
[32m+[m[41m[m
[32m+[m[41m[m
 <% if flash[:error] %>[m
 Not found.[m
 <% else %>[m
[36m@@ -5,8 +25,6 @@[m [mNot found.[m
   <h1><%= @friend.full_name %></h1>[m
 </div>[m
 [m
[31m-<p>[m
[31m-  Do you really want to friend <%= @friend.full_name %>?[m
[31m-</p>[m
[32m+[m[32m<p>Do you really want to friend <%= @friend.full_name %>?</p>[m[41m[m
 [m
 <% end %>[m
[1mdiff --git a/test/functional/user_friendships_controller_test.rb b/test/functional/user_friendships_controller_test.rb[m
[1mindex 7f51743..320982f 100644[m
[1m--- a/test/functional/user_friendships_controller_test.rb[m
[1m+++ b/test/functional/user_friendships_controller_test.rb[m
[36m@@ -35,7 +35,7 @@[m [mclass UserFriendshipsControllerTest < ActionController::TestCase[m
         assert_match /#{users(:john).full_name}/, response.body[m
       end[m
 [m
[31m-      should "assign a user friendship" do[m
[32m+[m[32m      should "assign a new user friendship" do[m
         get :new, friend_id: users(:john).id[m
         assert assigns(:user_friendship)[m
       end[m
[1mdiff --git a/test/unit/user_test.rb b/test/unit/user_test.rb[m
[1mindex f80ab71..7a4c4ec 100644[m
[1m--- a/test/unit/user_test.rb[m
[1m+++ b/test/unit/user_test.rb[m
[36m@@ -63,4 +63,9 @@[m [mclass UserTest < ActiveSupport::TestCase[m
     users(:giann).friends.reload[m
     assert users(:giann).friends.include?(users(:brian))[m
   end[m
[32m+[m
[32m+[m
[32m+[m[32m  test "that calling to_param on a user returns the profile_name" do[m
[32m+[m[32m    assert_equal "giannwilk", users(:giann). to_param[m
[32m+[m[32m  end[m
 end[m
[1mdiff --git a/tmp/pids/server.pid b/tmp/pids/server.pid[m
[1mindex bbf586e..9b4e1cc 100644[m
[1m--- a/tmp/pids/server.pid[m
[1m+++ b/tmp/pids/server.pid[m
[36m@@ -1 +1 @@[m
[31m-3764[m
\ No newline at end of file[m
[32m+[m[32m3656[m
\ No newline at end of file[m
