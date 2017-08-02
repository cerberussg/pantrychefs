require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Scott", email: "scott@yahoo.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "john1", email: "john1@example.com",
                          password: "password", password_confirmation: "password")
    @chef_admin = Chef.create!(chefname: "john", email: "john@example.com",
                          password: "password", password_confirmation: "password", admin: true)
  end
  
  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "scott@yahoo.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Scott Go", email: "scottgo@yahoo.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Scott Go", @chef.chefname
    assert_match "scottgo@yahoo.com", @chef.email
  end
  test "accept edit attempt by admin" do
    sign_in_as(@chef_admin, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Scott G", email: "scottg@yahoo.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Scott G", @chef.chefname
    assert_match "scottg@yahoo.com", @chef.email
  end
  
  test "redirect edit attempt by another non-admin" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "jo@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Scott", @chef.chefname
    assert_match "scott@yahoo.com", @chef.email
  end
end
