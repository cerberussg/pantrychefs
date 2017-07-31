class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
    @maximum_length = Recipe.validators_on( :ingredients ).second.options[:maximum]
    @max_length = Recipe.validators_on( :directions ).second.options[:maximum]
  end
end