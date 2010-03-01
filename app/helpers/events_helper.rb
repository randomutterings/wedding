module EventsHelper
  def calendar_view
    event = Event.find_by_scheduled_at(@date)
    calendar(:month => @date.month, :year => @date.year, :previous_month_text => "<a href='#{events_url}?date=#{@date.last_month}'>Prev</a>", :next_month_text => "<a href='#{events_url}?date=#{@date.next_month}'>Next</a>") do |d|
      events = @events.detect {|event| event.scheduled_at.to_date == d }
      events.blank? ? nil : [link_to(d.mday, event_url(:id => event)), {:class => 'specialDay'}]
    end
  end
end
