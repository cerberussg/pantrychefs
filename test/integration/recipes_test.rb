require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Scott", email: "scott@yahoo.com")
    @recipe = Recipe.create(name: "Cookies", chef: @chef, ingredients: "Testing", directions: "Testing")
    @recipe2 = @chef.recipes.build(name: "Fried Oreos", ingredients: "Testing", directions: "Testing")
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
