class AmzurEventsController < ApplicationController

  before_filter :hr_view,  only: ["new", "edit"]
  before_action :find_event, only: [:edit, :show, :update, :destroy]
  
  def index
   @amzurevent = AmzurEvent.all.page(params[:page]).per(5)
  end
  
  def new
   @amzurevent = AmzurEvent.new
  end
  
  def create
   @amzurevent = AmzurEvent.new(amzurevent_params)
   @users = User.all
   if @amzurevent.save
    Employee.where(status: false).each do |emp|
    Notification.delay.event_notification(emp.user,@amzurevent)
    end
    redirect_to amzur_events_path
   else
    flash.now[:error]
    render "new"
   end
  end
  
  def edit    
  end
  
  def show
    @event = AmzurEvent.all.page(params[:page]).per(5)
  end
  
  def update
     if @amzurevent.update(amzurevent_params)
        redirect_to amzur_events_path
      else
       flash.now[:error]
       render "edit"
    end   
  end
  
  def destroy
    @amzurevent.destroy
    redirect_to amzur_events_path 
  end
  
  
  private
  
  def amzurevent_params
     params.require(:amzur_event).permit(:title, :description, :held_on) 
  end
  
  def find_event
    @amzurevent = AmzurEvent.find(params[:id])
  end
  
end
