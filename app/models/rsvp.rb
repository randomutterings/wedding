class Rsvp < ActiveRecord::Base
  belongs_to  :guest
  belongs_to  :event
  validates_numericality_of :attending, :greater_than => 0, :message => " must be greater than 0, or click not attending.", :unless => :check_not_attending
  attr_accessor :not_attending
  attr_accessible :not_attending, :event_id, :guest_id, :message, :attending
  
  def check_not_attending
    not_attending == "1"
  end
end
