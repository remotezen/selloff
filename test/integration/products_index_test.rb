require "test_helper"

class ProductsIndexTest < Capybara::Rails::TestCase
  def setup
    @product = products(:one)
    @bid_one = bids(:one)
    @bid_two = bids(:two)


  end

  def test_display_products
    visit products_path
    assert page.has_css?('div.row')
    assert page.has_selector?('table tr td', text: @product.name)
    assert page.has_selector?('table.product-index-table tr td', text: @product.description)
  end

end
