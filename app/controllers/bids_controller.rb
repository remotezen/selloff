class BidsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @product = Product.find(params[:id])
    
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @bid = current_user.bids.build(bid_params)
    @bid.update_attribute(:product_id, params[:product_id])
      respond_to do |format|
        if @bid.save
          format.html { redirect_to products_url, notice: ' Your bid has recorded.' }
          format.json { render :show, status: :created, location: @bid }
        else
          format.html{render :new}
          format.json{render json: @bid.errors, status: :unprocessable_entity}
        end
      end
  end


  def update
  end

  def edit
  end

  def index
  end

  def show
    @product = Product.find(params[:id])
    if @current_bid
        format.js
    end
  end
  private
    def bid_params
      params.require(:bid).permit(:bidded)
    end
end
