require 'test_helper'

class FixingTest < ActiveSupport::TestCase
  
  def setup
    @ingredient = Fixing.create!(name: "Chicken")
  end
  
  test "should be valid" do
    assert @ingredient.valid?
  end
  
  test "name should be present" do
    @ingredient.name = " "
    assert_not @ingredient.valid?
  end
  
  test "name should be less than 25 characters" do
    @ingredient.name = "a" * 26
    assert_not @ingredient.valid?
  end
  
  test "name should be more than 3 characters" do
    @ingredient.name = "a" * 2
    assert_not @ingredient.valid?
  end
  
  test "Uniqueness of the ingredient" do
    @ingredient2 = Fixing.new(name: "Chicken")
    assert_not @ingredient2.valid?
  end
  
end