class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :required_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # @recipes = Recipe.paginate(page: params[:page], per_page: 2)
    @recipes = Recipe.order(:created_at).paginate(:page => params[:page], :per_page => 3)
    #@recipes = Recipe.paginate(:page => params[:page], :per_page => 3)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @ccomment = Ccomment.new
    @comments = @recipe.ccomments.order(:created_at).paginate(:page => params[:page], :per_page => 3)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      # save post
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit
    #@recipe = Recipe.find(params[:id])
  end

  def update
    #@recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe was deleted successfully!"
    redirect_to recipes_path
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])      
    end

    def recipe_params
      params.require(:recipe).permit(:name, :description, ingredient_ids: [])
    end

    def require_same_user
      if current_chef != @recipe.chef && !current_chef.admin?
        flash[:danger] = "You can only edit or delete your own recipes"
        redirect_to recipes_path
      end
    end

end