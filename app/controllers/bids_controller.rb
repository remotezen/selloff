class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_bid, only: :create
  before_action :check_increment, only: [:create]

  def new
    @product = Product.find(params[:id])

    respond_to do |format|
      format.js{}
    end
  end

  def create
    @bid = current_user.bids.build(bid_params)
     if @bid.save
      redirect_to product_path(params[:bid][:product_id]), notice: ' Your bid has recorded.'
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

    def check_bid
      product_id = params[:bid][:product_id]
      product = Product.find(product_id)
      highest = product.bids.maximum(:bidded)
      lowest  = product.minimum_bid
      you_bought_it = product.maximum_bid
      bidded = params[:bid][:bidded]
      if bidded.to_f <  highest.to_f
        flash[:error] = "your bid must exceed the highest bid so far"
        redirect_to product_path(product)
      elsif bidded.to_f < lowest
        flash[:error] = "Your bid is less than the minimum acceptable bid"
        redirect_to product_path(product)
      elsif bidded.to_f >= you_bought_it
        flash[:success] = "You have exceeded the maxmum bid. The item is yours for #{you_bought_it}"
        params[:bid][:bidded] = you_bought_it
      end
    end

    def check_increment
      product_id = params[:bid][:product_id]
      product = Product.find(product_id)
      highest = product.highest_bid.to_f
      bidded = params[:bid][:bidded].to_f
      increment = product.minimum_increment.to_f
      sum = increment.to_f + highest.to_f
      unless bidded >= sum
        flash[:error] = "Your bid must be at equal to or greater than #{sprintf "%.2f", increment} the highest bid so far"
        redirect_to products_path
      end
    end
end
