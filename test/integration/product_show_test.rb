require "test_helper"

class ProductShowTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:one)
    @bidders = @product.bids
    @highest_bid = @product.bids.maximum(:bidded)
    @number_of_bids = @product.bids.count
    @user = users(:one)
  end

  test "Products show" do
    sign_in(@user)
    get product_path(@product)

  end
end
