require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Guest.new.valid?
  end
end
