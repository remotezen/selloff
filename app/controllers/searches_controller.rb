class SearchesController < ApplicationController
  def index
    @products = Product.basic_search(params[:search])
    @bid = Bid.new
    @search = Search
  end
end
