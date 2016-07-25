require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  def line_item
    @line_item ||= LineItem.new
  end

  def test_valid
    assert line_item.valid?
  end
end
