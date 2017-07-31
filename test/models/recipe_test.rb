require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create!(chefname: "Scott", email: "goyette@gmail.com")
    @recipe = @chef.recipes.build(name: "vegetable", directions: "great vegetable recipe", ingredients: "Test stuff") 
  end
  
  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end 

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "ingrdients should be present" do
    @recipe.ingredients = " "
    assert_not @recipe.valid?
  end

  test "directions should be present" do
    @recipe.directions = " "
    assert_not @recipe.valid?
  end

  test "ingredients shouldn't be less than 5 characters" do
    @recipe.ingredients = "a" * 3
    assert_not @recipe.valid?
  end

  test "directions shouldn't be less than 5 characters" do
    @recipe.directions = "a" * 3
    assert_not @recipe.valid?
  end

  test "ingrdients shouldn't be more than 1500 characters" do
    @recipe.ingredients = "a" * 1501
    assert_not @recipe.valid?
  end

  test "directions shouldn't be more than 1500 characters" do
    @recipe.directions = "a" * 1501
    assert_not @recipe.valid?
  end
end