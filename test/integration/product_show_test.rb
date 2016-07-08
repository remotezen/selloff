require "test_helper"

class ProductShowTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:one)
  end
  
  test "Products show" do
    get product_path(@product)
    assert_match  "#{@product.name} Description", response.body

  end
end
