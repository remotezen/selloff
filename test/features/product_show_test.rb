require "test_helper"

class ProductShowTest < Capybara::Rails::TestCase
  def setup
    @product = products(:one)
    @user = users(:one)
    Capybara.default_driver = :selenium
  end
  test "Product basic content" do
    sign_in(@user)
    visit product_path(@product)
    assert page.has_text?(@product.name)
    assert page.has_text? @product.description
    assert page.has_link?('Edit', edit_product_path(@product))
    assert page.has_link?('Back', products_path)
    assert page.has_selector?('div.form-inputs', count:2)
    assert page.has_css?('div.form-actions')
    assert page.find_field('bid[bidded]')
    assert page.has_css?('.simple_form, .new_bid, #new_bid')
  end
  test 'form actions', :js => true do
    sign_in(@user)
    visit product_path(@product)
    fill_in('bid[bidded]', with: 10.10)
    click_button('Create Bid')
    assert page.has_selector?('span#highest_bid')
    assert page.has_text?(10.10)
    #assert page.has_text?("1 bid")

    assert_equal @product.bids.count, 1
    assert page.has_css?('#number_of_bids')

  end
end
