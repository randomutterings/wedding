class Article < ActiveRecord::Base
  require 'chronic'
  attr_accessible :title, :body, :published, :published_string
  attr_accessor :published_string
  validates_presence_of :title, :body
  
  def validate
    if date = Chronic.parse(self.published_string)
      self.published = date.to_s(:db)
    else
      self.errors.add :published_string, "was not a proper date"
    end
  end
  
  def published_formatted
    published.strftime "%A %B #{published.day.ordinalize}"
  end
  
end
