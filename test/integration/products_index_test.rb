require "test_helper"

class ProductsIndexTest < Capybara::Rails::TestCase
  def setup
    @product = products(:one)
    @bid_one = bids(:one)
    @bid_two = bids(:two)


  end
  def test_products_interface
    visit products_path
    assert page.has_link?("New Product") 
    assert page.has_link?("Bid")
  end
  
  def test_display_products
    visit products_path
    assert page.has_css?('div.row')
    assert page.has_selector?('div.col-md-2 h4', text: @product.name)
    assert page.has_selector?('div.col-md-3 h5', text: @product.description)
  end

end
