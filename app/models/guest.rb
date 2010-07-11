class Guest < ActiveRecord::Base
  attr_accessible :name, :email, :rsvps_attributes
  has_many  :rsvps, :dependent => :destroy
  has_many  :events, :through => :rsvps
  validates_presence_of :name, :email
  accepts_nested_attributes_for :rsvps, 
                                :allow_destroy => true
end
