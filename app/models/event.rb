class Event < ActiveRecord::Base
  require 'chronic'
  attr_accessible :title, :description, :scheduled_at, :rsvp
  has_many :rsvps
  has_many :guests, :through => :rsvps
  validates_presence_of :title  

  def validate
    if date = Chronic.parse(self.scheduled_at)
      self.scheduled_at = date.to_s(:db)
    else
      self.errors.add :scheduled_at, "was not a proper date"
    end
  end
  
  def scheduled_at_formatted(format = "datetime")
    if format == "datetime"
      scheduled_at.strftime "%a %b #{scheduled_at.day.ordinalize}, at %l:%M %p"
    elsif format == "date"
      scheduled_at.strftime "%A %B #{scheduled_at.day.ordinalize}"
    elsif format == "time"
      scheduled_at.strftime "%l:%M %p"
    elsif format == "chronic"
      scheduled_at.strftime "%b %d at %l:%M %p"
    end
  end
  
  def self.find_for_date(date)
    from = Time.parse("#{date} 00:00:00")
    to = Time.parse("#{date} 23:59:59")
    self.find(:all, :conditions => ["scheduled_at BETWEEN ? and ?", from, to])  
  end
  
end
