class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  # def index
  #   # binding.pry
  #   if params[:query].present?
  #     @products = Product.search(params[:query])
  #     Rails.logger.debug { "Search Results: #{@products.to_json}" }
  #   else
  #     @products = Product.all.order(created_at: :desc)
  #   end
  # end

  def index
  @products = Product.all

  if params[:query].present?
    @products = @products.search(params[:query])
  end

  if params[:category_id].present?
    @products = @products.where(category_id: params[:category_id])
  end

  if params[:colors].present?
    @products = @products.where("colors @> ?", "{#{params[:colors]}}")
  end

  if params[:sizes].present?
    @products = @products.where("sizes @> ?", "{#{params[:sizes]}}")
  end

  if params[:price_min].present?
    @products = @products.where('price >= ?', params[:price_min])
  end

  if params[:price_max].present?
    @products = @products.where('price <= ?', params[:price_max])
  end

  @products = @products.distinct
end

  
  

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found."
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  # def create
  #   binding.pry
  #   @product = Product.new(product_params)

  #   respond_to do |format|
  #     if @product.save
  #       format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
  #       format.json { render :show, status: :created, location: @product }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def create
    binding.pry
    @product = Product.new(product_params)
    if @product.save
       redirect_to products_path, notice: 'Product was successfully created.'
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  # PATCH/PUT /products/1 or /products/1.json
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    puts "Params ID: #{params[:id]}"
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def product_params
    #   params.require(:product).permit(:name, :description, :image)
    # end
    # def product_params
    #   params.require(:product).permit(:name, :description, :image, :category_id, :subcategory_id, colors: [], sizes: [])
    # end
    # def product_params
    #   # Convert colors and sizes to arrays if they are present
    #   params[:product][:colors] = params[:product][:colors].split(',') if params[:product][:colors].present?
    #   params[:product][:sizes] = params[:product][:sizes].split(',') if params[:product][:sizes].present?
    
    #   # Permit the parameters
    #   params.require(:product).permit(:name, :description, :image, :category_id, :subcategory_id, colors: [], sizes: [])
    # end
    def product_params
      params.require(:product).permit(:name, :description, :image, :category_id, :subcategory_id, variants: [:colors, :sizes])
    end
    
    
    
end
