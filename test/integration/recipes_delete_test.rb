require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great vegetable Saute, add vegetable and oil", chef: @chef)
  end


  test "Successfully delete a recipe" do
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_select "a[heref=#]", recipe_path(@recipe), text: "Delete this recipe"
    assert_difference "Recipe.count", -1 do
      delete recipe_path(@recipe)
    end
    assert_redirect_to recipes_path
    assert_not flash.empty?
  end

end
