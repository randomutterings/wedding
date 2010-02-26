require 'test_helper'

class GiftTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Gift.new.valid?
  end
end
