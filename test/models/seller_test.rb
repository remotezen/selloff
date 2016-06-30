require "test_helper"

class SellerTest < ActiveSupport::TestCase
  def seller
    @seller ||= Seller.new
  end

  def test_valid
    assert seller.valid?
  end
end
