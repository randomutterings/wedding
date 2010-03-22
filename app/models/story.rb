class Story < ActiveRecord::Base
  require 'chronic'
  attr_accessible :title, :body, :published_on
  validates_presence_of :title, :body
  
  def validate
    if date = Chronic.parse(self.published_on)
      self.published_on = date.to_s(:db)
    else
      self.errors.add :published_on, "was not a proper date"
    end
  end
  
  def published_on_formatted
    published_on.strftime "%A %B #{published_on.day.ordinalize}"
  end
end
