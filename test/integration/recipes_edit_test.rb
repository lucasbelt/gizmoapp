require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great vegetable Saute, add vegetable and oil", chef: @chef)
  end

  test "successfully edit recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    updated_name = "chicken saute"
    updated_description = "Add Chicken, add vegetable, cook for 20 minutes, serve delicious meal"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

  test "rejected invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "Some description" } }
    assert_template "recipes/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end
