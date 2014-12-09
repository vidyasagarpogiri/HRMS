class AmzurEventsController < ApplicationController

  #before_filter :hr_view,  only: ["new", "edit"]
  before_action :find_event, only: [:edit, :show, :update, :destroy]
  
  def index
   @amzurevent = AmzurEvent.all.page(params[:page]).per(5)
  end
  
  def new
   @amzurevent = AmzurEvent.new
   @departments = Department.all
   @groups =Group.all
   @workgroups =Workgroup.all
  end
  
  def create
  #raise params.inspect
   case params[:eventable_type] 
    
    when "Group"
    
        @amzurevent = Group.find(params[:group_id]).amzur_events.new(amzurevent_params)
        
        if @amzurevent.save
        @amzurevent.update(:employee_id => current_user.employee.id)
        Employee.where(status: false).each do |emp|
        #Notification.delay.event_notification(emp.user,@amzurevent)
        end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "new"
       end
    
    when "Department"
      @amzurevent = Department.find(params[:department_id]).amzur_events.new(amzurevent_params )
    
      if @amzurevent.save
      @amzurevent.update(:employee_id => current_user.employee.id)
      Employee.where(status: false).each do |emp|
      #Notification.delay.event_notification(emp.user,@amzurevent)
      end
      redirect_to amzur_events_path
     else
      flash.now[:error]
      render "new"
     end
      
    when "Workgroup"
        @amzurevent = Workgroup.find(params[:department_id]).amzur_events.new(amzurevent_params)
    
        if @amzurevent.save
        @amzurevent.update(:employee_id => current_user.employee.id)
        Employee.where(status: false).each do |emp|
        #Notification.delay.event_notification(emp.user,@amzurevent)
        end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "new"
       end
    else 
      @amzurevent = current_user.employee.amzur_events.new(amzurevent_params)
      if @amzurevent.save
      Employee.where(status: false).each do |emp|
      #Notification.delay.event_notification(emp.user,@amzurevent)
      end
      redirect_to amzur_events_path
     else
      flash.now[:error]
      render "new"
     end
    
    end

  end
  
  def edit
   @amzurevent = AmzurEvent.find(params[:id])
   @departments = Department.all
   @groups =Group.all
   @workgroups =Workgroup.all   
  end
  
  def show
    @employee =curremt_user.employee
    @event = @employee.amzur_events.page(params[:page]).per(5)
  end
  
  def update
  
  
  case params[:eventable_type] 
    
    when "Group"
    
        @amzurevent = current_user.employee.group.amzur_events.update(amzurevent_params)
        
        if @amzurevent
        Employee.where(status: false).each do |emp|
        #Notification.delay.event_notification(emp.user,@amzurevent)
        end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "edit"
       end
    
    when "Department"
      @amzurevent = current_user.employee.department.amzur_events.update(amzurevent_params )
    
      if @amzurevent
      Employee.where(status: false).each do |emp|
      #Notification.delay.event_notification(emp.user,@amzurevent)
      end
      redirect_to amzur_events_path
     else
      flash.now[:error]
      render "edit"
     end
      
    when "Workgroup"
        @amzurevent = current_user.employee.workgroup.amzur_events.update(amzurevent_params )
    
        if @amzurevent
        Employee.where(status: false).each do |emp|
        #Notification.delay.event_notification(emp.user,@amzurevent)
        end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "edit"
       end
    else 
      @amzurevent = current_user.employee.amzur_events.update(amzurevent_params)
      if @amzurevent
      Employee.where(status: false).each do |emp|
      #Notification.delay.event_notification(emp.user,@amzurevent)
      end
      redirect_to amzur_events_path
     else
      flash.now[:error]
      render "edit"
     end
    
    end
   
  end
  
  def destroy
    @amzurevent.destroy
    redirect_to amzur_events_path 
  end
  
  
  def getallgroups
  end
  def getallworkgroups
  end
  
  
  private
  
  def amzurevent_params
     params.require(:amzur_event).permit(:title, :description, :held_on) 
  end
  
  def find_event
    @amzurevent = AmzurEvent.find(params[:id])
  end
  
end
