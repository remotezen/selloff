require "test_helper"

class ProductShowTest < ActionDispatch::IntegrationTest
  fixtures :products
  def setup
    @product = products(:one)
  end
  def test_products_show
    page.has_css?("product-header", text: "Minimum bid:" )
    page.has_css?("product-description", text: @product.description)
    page.has_css?('p', @product.name)
    page.has_css?('mark', @product.maximum_bid)
    page.has_css?('mark', @product.minimum_bid)
    page.has_css?('photo-box rounded')
  end
end
