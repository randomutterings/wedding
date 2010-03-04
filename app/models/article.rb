class Article < ActiveRecord::Base
  require 'chronic'
  attr_accessible :title, :body, :published_on, :published_on_string
  attr_accessor :published_on_string
  validates_presence_of :title, :body
  
  def validate
    if date = Chronic.parse(self.published_on_string)
      self.published_on = date.to_s(:db)
    else
      self.errors.add :published_on_string, "was not a proper date"
    end
  end
  
  def published_on_formatted
    published_on.strftime "%A %B #{published_on.day.ordinalize}"
  end
  
end
