class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  autocomplete :product, :name

  # GET /products
  # GET /products.json

  def index
    @products = Product.all
    @bid = Bid.new
    @bidders = []
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @bid = Bid.new
    unless @product.bids.nil?
      @bidders = Bid.where(product_id: params[:id]).limit(5)
      @highest_bid = @product.bids.maximum(:bidded)
      @number_of_bids = @product.bids.count
      gon.watch.highest_bid = @highest_bid
      gon.watch.number_of_bids = @number_of_bids
    else
      @bidders = []
      @highest_bid = 0
      @number_of_bids = 0
    end
    countdown = set_countdown(@product.created_at, 30)
    time_hash = date_to_hash(countdown)
    gon.time_hash = time_hash
  end

  # GET /products/new
  def new
    @product = Product.new
  end


  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:image, :minimum_bid, :maximum_bid,
                                      :description, :name, :category, :user_id)
    end
end
