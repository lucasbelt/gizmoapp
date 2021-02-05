require "test_helper"

class ProductTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(username: "lucasbelt", email: "lucas@example.com",
                    password: "password", password_confirmation: "password")
    @product = @user.products.build(name: "Vegetable", description: "Great Vegetable Recipe")
  end

  test "Product without user should be invalid" do
    @product.user_id = nil
    assert_not @product.valid?
  end

  test "product should be valid" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.name = " "
    assert_not @product.valid?
  end

  test "description should be present" do
    @product.description = " "
    assert_not @product.valid?
  end

  test "description shouldn't be less than 5 characters" do
    @product.description = "a" * 3
    assert_not @product.valid?
  end

  test "description shouldn't be more than 500 characters" do
    @product.description = "a" * 501
    assert_not @product.valid?
  end

end