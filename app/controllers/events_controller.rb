class EventsController < ApplicationController
  def index
    @events = Event.all
    if params[:date].nil?
      @date = Date.today
    else
      @date = params[:date].to_date
    end
  end
  
  def show
    @event = Event.find(params[:id])
    from = Time.parse("#{@event.scheduled_at.to_date} 00:00:00")
    to = Time.parse("#{@event.scheduled_at.to_date} 23:59:59")
    @events = Event.find(:all, :conditions => ["scheduled_at BETWEEN ? and ?", from, to])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to @event
    else
      render :action => 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to @event
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to events_url
  end
end
