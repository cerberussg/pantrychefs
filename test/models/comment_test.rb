require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chefname: "Scott", email: "scott@yahoo.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name: "Cookies", chef: @chef, ingredients: "Testing", directions: "Testing")
    @comment = Comment.create!(comment_text: "Great recipe!", chef: @chef , recipe: @recipe)
  end
  
  test "should be valid comment" do
    assert @comment.valid?
  end
  
  test "comment without comment_text not valid" do
    @comment.comment_text = " "
    assert_not @comment.valid?
  end
  
  test "comment without chef not valid" do
    @comment.chef = nil
    assert_not @comment.valid?
  end
  
  test "comment without recipe not valid" do
    @comment.recipe = nil
    assert_not @comment.valid?
  end
  
  test "comment should be longer than 4 characters" do
    @comment.comment_text = "a" * 3
    assert_not @comment.valid?
  end
  
  test "comment should not be longer than 300 characters" do
    @comment.comment_text = "a" * 301
    assert_not @comment.valid?
  end
end