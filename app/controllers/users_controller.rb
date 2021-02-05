class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    #debugger
    @user = User.new(user_params)
    if @user.save
      # save post
      flash[:success] = "Welcome #{@user.username} to GizmoApp!"
      redirect_to user_path(@user)
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
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])      
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end