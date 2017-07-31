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
  
  def create
    @recipe = Recipe.new(recipe_param)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  
  private
  
    def recipe_param
      params.require(:recipe).permit(:name, :ingredients, :directions)
    end
end