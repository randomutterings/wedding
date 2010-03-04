class Page < ActiveRecord::Base
  attr_accessible :name, :permalink, :content
end
