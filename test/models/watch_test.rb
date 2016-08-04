require "test_helper"

class WatchTest < ActiveSupport::TestCase
  def watch
    @watch ||= Watch.new
  end

  def test_valid
    assert watch.valid?
  end
end
