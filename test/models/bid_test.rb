require "test_helper"

class BidTest < ActiveSupport::TestCase
  context "bid Validations " do
    setup{
      @bid = bids(:one)
    }
    should belong_to :user
    should have_db_column(:bidded)
    should belong_to :product
    should validate_numericality_of(:bidded)
  end
end
