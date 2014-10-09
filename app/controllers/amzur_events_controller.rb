class AmzurEventsController < ApplicationController

  before_filter :hr_view,  only: ["new", "edit"]
  
  def index
   @amzurevent = AmzurEvent.all.page(params[:page]).per(3)
  end
  
  def new
  #raise params.inspect
   @amzurevent = AmzurEvent.new
  end
  
  def create
  #raise params.inspect
   @amzurevent = AmzurEvent.new(amzurevent_params)
  
    if @amzurevent.save
      redirect_to amzur_events_path
    else
       flash.now[:error]
       render "new"
    end
  end
  
  def edit
    @amzurevent = AmzurEvent.find(params[:id]) 
  end
  
  def show
    @amzurevent = AmzurEvent.find(params[:id])
    @event = AmzurEvent.all
  end
  
  def update
    @amzurevent = AmzurEvent.find(params[:id])
     if @amzurevent.update(amzurevent_params)
        redirect_to amzur_events_path
      else
       flash.now[:error]
       render "edit"
    end   
  end
  
  def destroy
  #raise params.inspect
    @amzurevent =  AmzurEvent.find(params[:id])
    @amzurevent.destroy
    redirect_to amzur_events_path 
  end
  
  
  private
  
  def amzurevent_params
  #raise params.inspect
     params.require(:amzur_event).permit(:title, :description, :held_on) 
  end
  
end
