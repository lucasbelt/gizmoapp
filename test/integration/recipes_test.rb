require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
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
    assert_select "a[href=?]", recipe_url(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_url(@recipe2), text: @recipe2.name
  end

  test "Should get recipe show" do
    get recipes_url(@recipe)
    assert_template "recipes/show"
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "Create new valid recipe" do
    get new_recipe_path
    assert_template "recipes/new"
    name_of_recipe = "chicken saute"
    description_of_recipe = "Add Chicken, add vegetable, cook for 20 minutes, serve delicious meal"
    assert_difference "Recipe.count", 1 do
      post recipes_url, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
    end
    follow_redirect!
    assert_template "recipes/show"
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "Reject invalid recipe submissions" do
    get new_recipe_path
    assert_template "recipes/new"
    assert_no_difference "Recipe.count" do
      post recipes_url, params: { recipe: { name: " ", description: " " } }
    end
    assert_template "recipes/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end
