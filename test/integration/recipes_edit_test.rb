require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Scott", email: "scott@yahoo.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Cookies", chef: @chef, ingredients: "Testing", directions: "Testing")
  end
  
  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", ingredients: "some ingredients", directions: "some directions"} }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_ingredients = "updated recipe ingredients"
    patch recipe_path(@recipe), params: { recipe: {name: updated_name, ingredients: updated_ingredients } }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_ingredients, @recipe.ingredients
  end
  
end
