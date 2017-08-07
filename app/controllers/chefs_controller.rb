class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 10)
  end
  def new
    @chef = Chef.new
  end
  
  def create
    @chef= Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      cookies.signed[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.chefname} to Pantry Chefs"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end
  
  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 10)
  end
  
  def edit
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @chef
    else
      render 'edit'
    end
  end
  
  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger] = "chef and all recipes have been deleted!"
      redirect_to chefs_path
    end
  end
  
  private
  ## To create a chef users must meet the requirements to create account
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
  ## Useful to set the @chef variable to chef by id
  def set_chef
    @chef = Chef.find(params[:id])
  end
  ## Prevents other users from editing other Chefs reicpes, Admin can edit all
  def require_same_user
    if current_chef != @chef and !current_chef.admin?
      flash[:danger] = "You can only eidt or delete your own account"
      redirect_to chefs_path
    end
  end
  ## Validates whether user is admin
  def require_admin
    if logged_in? && !current_chef.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
end