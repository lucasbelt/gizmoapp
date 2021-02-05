require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "reject an invalid user edit" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { username: " ", email: "mashrur@example.com" } }
    assert_template "users/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

  test "accept valid user edit" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { username: "mashrur_01", email: "mashrur_01@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur_01", @user.username
    assert_match "mashrur_01@example.com", @user.email
  end

end
