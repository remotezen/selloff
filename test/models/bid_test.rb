require "test_helper"

class BidTest < ActiveSupport::TestCase
  def bid
    @bid ||= Bid.new
  end

  def test_valid
    assert bid.valid?
  end
end
