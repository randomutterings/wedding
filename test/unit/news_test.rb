require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert News.new.valid?
  end
end
