require "test_helper"

class ProductTest < ActiveSupport::TestCase
  context "#### User validations ###" do
    should belong_to :user
    should validate_presence_of :description
    should validate_presence_of :name
    should validate_length_of(:name).is_at_least(3).is_at_most(40)

  end
end
