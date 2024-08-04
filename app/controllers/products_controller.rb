class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    # binding.pry
    if params[:query].present?
      @products = Product.search(params[:query])
      Rails.logger.debug { "Search Results: #{@products.to_json}" }
    else
      @products = Product.all.order(created_at: :desc)
    end
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
    # binding.pry
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
    def product_params
      params.require(:product).permit(:name, :description, :image, :category_id, :subcategory_id, colors: [], sizes: [])
    end
    
end
