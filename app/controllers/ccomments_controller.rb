class CcommentsController < ApplicationController
  before_action :required_user


  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.ccomments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      ActionCable.server.broadcast "ccomments_channel", render(partial: "ccomments/comment", object: @comment)
      # flash[:success] = "Comment was created successfully!"
      # redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Comment was not created!"
      redirect_to :back
    end
  end

  private

    def comment_params
      params.require(:ccomment).permit(:description)
    end

end