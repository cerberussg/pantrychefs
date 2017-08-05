class FixingsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]
  
  def index
    @fixings = Fixing.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @fixing_recipes = @fixing.recipes.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @fixing = Fixing.new
  end
  
  def edit
  
  end
  
  def create
    @fixing = Fixing.new(fixing_params)
    if @fixing.save
      flash[:success] = "Ingredient was successfully created"
      redirect_to fixing_path(@fixing)
    else
      render 'new'
    end
  end
  
  def update
    if @fixing.update(fixing_params)
      flash[:success] = "Ingredient was updated successfully"
      redirect_to @fixing
    else
      render 'edit'
    end
  end
  
  private
  
  def fixing_params
    params.require(:fixing).permit(:name)
  end
  
  def set_ingredient
    @fixing = Fixing.find(params[:id])
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_chef.admin?)
      flash[:danger] = " Only admin users can perform that action"
      redirect_to fixing_path
    end
  end
  
end