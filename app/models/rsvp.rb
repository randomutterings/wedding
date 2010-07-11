class Rsvp < ActiveRecord::Base
  belongs_to  :guest
  belongs_to  :event
  validates_numericality_of :attending, :greater_than => 0, :message => " cannot be blank."
end
