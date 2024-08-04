class CategoriesController < ApplicationController
    before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  
    def index
      @categories = Category.all
    end
  
    def show
      @category = Category.find(params[:id])
  
      @products = @category.products
  
      # Apply filters if provided
      @products = @products.where('price >= ?', params[:min_price]) if params[:min_price].present?
      @products = @products.where('price <= ?', params[:max_price]) if params[:max_price].present?
      @products = @products.where('variants @> ?', { colors: params[:colors] }.to_json) if params[:colors].present?
      @products = @products.where('variants @> ?', { sizes: params[:sizes] }.to_json) if params[:sizes].present?
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to @category, notice: 'Category was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @category = Category.find(params[:id])
    end
  
    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to @category, notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    end
  
    private
  
    def category_params
      params.require(:category).permit(:name, :parent_id)
    end
  end
  