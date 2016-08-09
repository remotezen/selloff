require "test_helper"

class ProductIndexTest < Capybara::Rails::TestCase
  def setup
    @product = products(:one)
    @user = users(:one)
  end
  test "index basic content" do
    sign_in(@user)
    visit products_path
    assert page.has_text?(@product.name)
    assert page.has_text?(@product.description)
  end

end
