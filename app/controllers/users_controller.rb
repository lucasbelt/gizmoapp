class UsersController < ApplicationController

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
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end