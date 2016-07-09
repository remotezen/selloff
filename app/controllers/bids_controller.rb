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
     if @bid.save
      redirect_to products_url, notice: ' Your bid has recorded.' 
     else
        redirect_to product_path(@bid.product_id), :flash => { :error => @bid.errors.full_messages.join(', ') }

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
      params.require(:bid).permit(:bidded, :product_id)
    end
end
