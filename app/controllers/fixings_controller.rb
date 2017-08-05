class FixingsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]
  
  def index
    @fixings = Fixing.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @fixing_recipes = @fixing.recipes.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    
  end
  
  def edit
  
  end
  
  def create
    
  end
  
  def update
    
  end
  
  private
  
  def set_ingredient
    @fixing = Fixing.find(params[:id])
  end
  
end