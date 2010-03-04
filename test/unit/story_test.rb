require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Story.new.valid?
  end
end
