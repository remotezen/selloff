require "test_helper"

class ProductShowTest < ActionDispatch::IntegrationTest
  fixtures :users
  def setup
    @user = users(:one)
  end
  def test_products_show
    page.assert_selector("span.product-header", text: )
  end
end
