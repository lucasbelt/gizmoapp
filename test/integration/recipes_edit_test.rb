require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great vegetable Saute, add vegetable and oil", chef: @chef)
  end

  test "Successfully edit recipe" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    updated_name = "chicken saute"
    updated_description = "Add Chicken, add vegetable, cook for 20 minutes, serve delicious meal"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name.capitalize, @recipe.name
    assert_match updated_description, @recipe.description
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete this recipe"
  end

  test "rejected invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "Some description" } }
    assert_template "recipes/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end
