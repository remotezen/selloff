require 'test_helper'
class VisitorIndexTest < ActionDispatch::IntegrationTest
  def test_visitors_index
    visit root_path
    page.assert_selector("h3", text: "Home Page")
    page.assert_title( "Home Page | Sell Off Auction")
    page.has_content?("Home Page")
  end
end
