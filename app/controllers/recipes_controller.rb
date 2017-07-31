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
  
  def edit
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])
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
  
    def recipe_param
      params.require(:recipe).permit(:name, :ingredients, :directions)
    end
end