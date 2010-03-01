class Event < ActiveRecord::Base
  require 'chronic'
  attr_accessible :title, :description, :scheduled_at, :scheduled_string
  attr_accessor :scheduled_string
  
  validates_presence_of :title
  
  def validate
    if date = Chronic.parse(self.scheduled_string)
      self.scheduled_at = date
    else
      self.errors.add :scheduled_string, "was not a proper date"
    end
  end
  
  def scheduled_at_formatted(time = true, date = true)
    if time == true && date == true
      scheduled_at.strftime "%a %b #{scheduled_at.day.ordinalize}, at %l:%M %p"
    elsif time == false && date == true
      scheduled_at.strftime "%A %B #{scheduled_at.day.ordinalize}"
    elsif time == true && date == false
      scheduled_at.strftime "%l:%M %p"  
    end
  end
  
end
