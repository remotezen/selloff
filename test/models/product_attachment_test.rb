require "test_helper"

class ProductAttachmentTest < ActiveSupport::TestCase
  def product_attachment
    @product_attachment ||= ProductAttachment.new
  end

  def test_valid
    assert product_attachment.valid?
  end
end
