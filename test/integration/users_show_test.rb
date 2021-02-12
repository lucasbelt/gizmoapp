require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "luisc", email: "luisc@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "luisc.correa", email: "luisc.correa@example.com",
                    password: "password", password_confirmation: "password", admin: true)
    @product = Product.create(name: "Vegetable Saute", description: "Great vegetable Saute, add vegetable and oil", user: @user)
    @product2 = @user.products.build(name: "Chicken Saute", description: "Great chicken dish")
    @product2.save
  end

  test "should get users show" do
    get user_path(@user)
    assert_template "users/show"
    assert_select "a[href=?]", product_path(@product), text: @product.name
    assert_select "a[href=?]", product_path(@product2), text: @product2.name
    assert_match @product.description, response.body
    assert_match @product2.description, response.body
    assert_match @user.username, response.body
  end

  test "Should get users listing" do
    get users_path
    assert_template "users/index"
    #assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.chefname
  end

  test "Should delete user" do
    sign_in_as(@admin_user, "password")
    get users_path
    assert_template "users/index"
    assert_difference "User.count", -1 do
      delete user_path(@user2)
    end
    assert_redirected_to users_path
    assert_not flash.empty?
  end

end
