class EventsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  def index
    @events = Event.all.sort_by{|e| e.scheduled_at}
  end
  
  def show
    @event = Event.find(params[:id])
    @events = Event.find_for_date(@event.scheduled_at.to_date)
  end
  
  def new
    @event = Event.new
    @event.scheduled_at = Time.now.strftime "%b %d at %l:%M %p"
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
    @event.scheduled_at = @event.scheduled_at_formatted("chronic")
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
