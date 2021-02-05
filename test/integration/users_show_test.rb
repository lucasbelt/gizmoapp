require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
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

end
