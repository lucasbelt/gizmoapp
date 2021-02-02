require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great vegetable Saute, add vegetable and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Great chicken dish")
    @recipe2.save
  end

  test "Should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "Should get recipes listing" do
    get recipes_url
    assert_template "recipes/index"
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

end
