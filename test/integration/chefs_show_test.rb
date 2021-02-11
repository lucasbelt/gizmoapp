require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "luisc", email: "luisc@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "luisc.correa", email: "luisc.correa@example.com",
                    password: "password", password_confirmation: "password", admin: true)
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great vegetable Saute, add vegetable and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Great chicken dish")
    @recipe2.save
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template "chefs/show"
    assert_select "a[href=?]", recipe_url(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_url(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "Should get chefs listing" do
    get chefs_path
    assert_template "chefs/index"
    #assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname
  end

  test "Should delete chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path
    assert_template "chefs/index"
    assert_difference "Chef.count", -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end
