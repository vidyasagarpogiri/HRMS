class EventsController < ApplicationController
   
layout "leave_template" 
 
 def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

 
  def new
    @event = Event.new
  end

 
  def edit
    @event = Event.find(params[:id])
  end

 
  def create
    #raise params.inspect
    @event = Event.create(event_params)
    redirect_to events_path
  end

  
  def update
   #raise params.inspect
   @event = Event.find(params[:id])
   @event.update(event_params)
  
   redirect_to events_path
  end

  
  def destroy
   @event = Event.find(params[:id])
   @event.destroy
   redirect_to events_path 
  end

  private
   
    def event_params
      params.require(:event).permit(:event_name, :event_date)
    end
end
