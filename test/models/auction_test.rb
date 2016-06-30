require "test_helper"

class AuctionTest < ActiveSupport::TestCase
  def auction
    @auction ||= Auction.new
  end

  def test_valid
    assert auction.valid?
  end
end
