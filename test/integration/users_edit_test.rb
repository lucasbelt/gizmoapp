require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "luisc", email: "luisc@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = User.create!(username: "luisc.correa", email: "luisc.correa@example.com",
                    password: "password", password_confirmation: "password", admin: true)
  end

  test "reject an invalid user edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { username: " ", email: "mashrur@example.com" } }
    assert_template "users/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

  test "accept valid user edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { username: "mashrur_01", email: "mashrur_01@example.com" } }
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur_01", @user.username
    assert_match "mashrur_01@example.com", @user.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { username: "mashrur_01", email: "mashrur_01@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur_01", @user.username
    assert_match "mashrur_01@example.com", @user.email
  end

  test "redirect edit attempt by another user non-admin user" do
    sign_in_as(@user2, "password")
    updated_name = "Joe"
    updated_email = "joe@example.com"
    patch user_path(@user), params: { user: { username: updated_name, email: updated_email } }
    assert_redirected_to users_path
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur_01", @user.username
    assert_match "mashrur_01@example.com", @user.email
  end

end
