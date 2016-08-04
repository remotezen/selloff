class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :user_seller, only: [:new, :edit, :update, :destroy]
  before_action :correct_seller, only: [:edit, :update, :destroy]
  before_action :has_bids, only: [:edit, :update, :destroy]
  autocomplete :product, :name

  # GET /products
  # GET /products.json

  def index
    @products = Product.all
    @bid = Bid.new
    @bidders = []
    unless current_user.nil?
      @watches = current_user.watches
    else
      @watches = []
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @product_attachments = @product.product_attachments
    @bid = Bid.new
    unless current_user.blank?
      @wacthes = current_user.watches
    else
      @watches = []
    end
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
    countdown = set_countdown(@product.expiration)
    time_hash = date_to_hash(countdown)
    gon.time_hash = time_hash
  end

  # GET /products/new
  def new
    @product = Product.new
  end



  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product updated"
      redirect_to @product
    else

      render 'edit'
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)
    respond_to do |format|
      if @product.save
        unless params[:product_attachments].blank?
          params[:product_attachments]['image'].each do |i|
            @product_attachments_attributes = @product.product_attachments.create!(image: i)
          end
        end

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
    def user_seller
       redirect_to root_url unless current_user.seller?
    end
    def correct_seller
      product = Product.find(params[:id])
      redirect_to  root_url unless current_user.id == product.user_id
    end
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:minimum_bid, :maximum_bid,
                                      :description, :name, :expiration,
                                      :category, :user_id,
                                      product_attachments_attributes: [:id, :product_id, :image])
    end
    def has_bids
        @product = Product.find(params[:id])
        redirect_to @product, info: "this product is being bidded on" if has_bids?(@product)
    end
end
