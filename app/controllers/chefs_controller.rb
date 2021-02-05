class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update]

  def index
    @chefs = Chef.all
  end

  def new
    @chef = Chef.new
  end

  def create
    #debugger
    @chef = Chef.new(chef_params)
    if @chef.save
      # save post
      flash[:success] = "Welcome #{@chef.chefname} to GizmoApp!"
      redirect_to chef_path(@chef)
    else
      render "new"
    end
  end

  def show
    #@chef = Chef.find(params[:id])
  end

  def edit
    #@chef = Chef.find(params[:id])
  end

  def update
    #@recipe = Recipe.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @chef
    else
      render 'edit'
    end
  end

  private

    def set_chef
      @chef = Chef.find(params[:id])      
    end

    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end

end