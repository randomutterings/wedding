class Photo < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "400x240#", :large => "500x" }
end
