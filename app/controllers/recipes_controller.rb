class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]
  def index
    @recipes = Recipe.all
  end
  
  def show
  end
  
  def new
    @recipe = Recipe.new
    @maximum_length = Recipe.validators_on( :ingredients ).second.options[:maximum]
    @max_length = Recipe.validators_on( :directions ).second.options[:maximum]
  end
  
  def edit
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
  
  def update
    if @recipe.update(recipe_param)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end
  
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted successfully!"
    redirect_to recipes_path
  end
  
  private
  
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  
    def recipe_param
      params.require(:recipe).permit(:name, :ingredients, :directions)
    end
end