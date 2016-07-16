class SearchesController < ApplicationController
  def index
    @products = Product.fuzzy_search(name: params[:search])
    @bid = Bid.new
    @bidders = []

  end
end
