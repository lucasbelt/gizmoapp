class ProductsController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]

  def index
    @products = Product.all
  end

  def show
    #@recipe = Recipe.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = User.first
    if @product.save
      # save post
      flash[:success] = "Product was created successfully!"
      redirect_to product_path(@product)
    else
      render "new"
    end
  end

  def edit
    #@product = Recipe.find(params[:id])
  end

  def update
    #@product = Recipe.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "Product was updated successfully!"
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id]).destroy
    flash[:success] = "product was deleted successfully!"
    redirect_to products_path
  end

  private

    def set_recipe
      @product = Product.find(params[:id])      
    end

    def product_params
      params.require(:product).permit(:name, :description)
    end

end