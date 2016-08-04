class SearchesController < ApplicationController
  def index
    @searches = Product.fuzzy_search(name: params[:search])
    @bid = Bid.new
    @bidders = []


  end
end
