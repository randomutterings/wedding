class Member < ActiveRecord::Base
  attr_accessible :name, :bio, :photo
  validates_presence_of :name
  has_attached_file :photo, :styles => { :medium => "200x200>" }
end
