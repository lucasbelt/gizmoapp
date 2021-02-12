require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "invalid user login is rejected" do
    get userarea_path
    assert_template "cookies/new"
    post userarea_path, params: { session: { email: " ", password: " " } }
    assert_template "cookies/new"
    assert_not flash.empty?
    assert_select "a[href=?]", userarea_path
    assert_select "a[href=?]", userlogout_path, count: 0
    get root_path
    assert flash.empty?
  end

  test "valid loging credentials accepted and begin session" do
    get userarea_path
    assert_template "cookies/new"
    post userarea_path, params: { session: { email: @user.email, password: @user.password } }
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert_select "a[href=?]", userarea_path, count: 0
    assert_select "a[href=?]", userlogout_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@uset)
  end

end
