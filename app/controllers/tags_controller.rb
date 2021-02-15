class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update]
  before_action :require_admin, except: [:show, :index]

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      # save post
      flash[:success] = "Tag was created successfully!"
      redirect_to tag_path(@tag)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:success] = "Tag was updated successfully!"
      redirect_to tag_path(@tag)
    else
      render 'edit'
    end
  end

  def show
    @tag_products = @tag.products.paginate(page: params[:page], per_page: 5)
  end

  def index
    @tags = Tag.paginate(page: params[:page], per_page: 5)
  end

  private

    def tag_params
      params.require(:tag).permit(:name)      
    end

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def require_admin
      if !user_logged_in? || (user_logged_in? && !current_user.admin?)
        flash[:danger] = "Only admin users can perform that action"
        redirect_to tags_path
      end
    end

end