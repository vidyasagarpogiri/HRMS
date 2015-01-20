class EventsController < ApplicationController


  before_filter :hr_admin_view,  only: ["new", "edit"]
  before_filter :other_emp_view  

 
 def index
    @users = User.all
    @events = Event.all
    @event_for_file = Event.select(:event_name, :event_date)
   respond_to do |format|
    format.html
    format.csv { send_data @event_for_file.to_csv.gsub(",created_at,updated_at","").gsub("id","") }
    format.xls { send_data @event_for_file.to_csv(col_sep: "\t").gsub("created_at\tupdated_at","").gsub("id","") }
    @users.each do |user|
      #Notification.holiday_list(user,@events).deliver
      end
    end
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
    @event = Event.new(event_params)
    if @event.save
    redirect_to events_path
    else
     flash.now[:error]
     render "new"
    end
  end
  
  def update
   @event = Event.find(params[:id])
   @event.update(event_params)
   redirect_to events_path
  end
 
  def destroy
   @event = Event.find(params[:id])
   @event.destroy
   redirect_to events_path 
  end
  
  def holiday_notification
     @users = User.all
     @events = Event.all
        Employee.where(status: false).each do |emp|
        #Notification.delay.holiday_list(emp.user,@events)
         flash.now[:error]
       end
       render "index"
  end  

  private
   
    def event_params
      params.require(:event).permit(:event_name, :event_date)
    end
end
