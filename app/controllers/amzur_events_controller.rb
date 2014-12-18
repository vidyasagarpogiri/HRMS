class AmzurEventsController < ApplicationController

  #before_filter :hr_view,  only: ["new", "edit"]
  before_action :find_event, only: [:edit, :show, :update, :destroy]
  
  def index
   @amzurevent = AmzurEvent.all.page(params[:page]).per(5)
   @empevents = current_user.employee.amzur_events
   @emp_dept_events = current_user.employee.department.amzur_events - (@empevents).to_a
   @emp_group_events = current_user.employee.group.amzur_events  - (@empevents).to_a
   @emp_workgroup_events =current_user.employee.workgroups.map(&:amzur_events).flatten - (@empevents).to_a
   
  end
  
  def new
   @amzurevent = AmzurEvent.new
   @departments = Department.all
   @groups =Group.all
   @workgroups =Workgroup.all
  end
  ##############
  #creatating an Amzur event by current user modified by @pattabhi 8th Dec 2014
  ##############
  def create
  #raise params.inspect
   case params[:eventable_type] 
    
    when "Group"
    
        @amzurevent = Group.find(params[:group_id]).amzur_events.new(amzurevent_params)
        
        if @amzurevent.save
        @amzurevent.update(:employee_id => current_user.employee.id)
        #send notification mail
         
          if @amzurevent.is_send_mail
            #raise params.inspect
            Group.find(params[:group_id]).employees.where(status: false).each do |emp|
            Notification.delay.event_notification(emp.user,@amzurevent)
            end
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
        if @amzurevent.is_send_mail
          Department.find(params[:department_id]).employees.where(status: false).each do |emp|
          Notification.delay.event_notification(emp.user,@amzurevent)
          end
        end
      redirect_to amzur_events_path
     else
      flash.now[:error]
      render "new"
     end
      
    when "Workgroup"
    #raise params.inspect
        @amzurevent = Workgroup.find(params[:workgroup_id]).amzur_events.new(amzurevent_params)
    
        if @amzurevent.save
        @amzurevent.update(:employee_id => current_user.employee.id)
          if @amzurevent.is_send_mail
          
            Workgroup.find(params[:workgroup_id]).employees.where(status: false).each do |emp|
            Notification.delay.event_notification(emp.user,@amzurevent)
            end
          end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "new"
       end
    else 
      @amzurevent = current_user.employee.amzur_events.new(amzurevent_params)
      if @amzurevent.save
        if @amzurevent.is_send_mail
          Employee.where(status: false).each do |emp|
          Notification.delay.event_notification(emp.user,@amzurevent)
          end
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
    @amzurevent =AmzurEvent.find(params[:id])
    @event = AmzurEvent.all.page(params[:page]).per(5)
  end
  #################
  #creatating an Amzur event by current user modified by @pattabhi 8th Dec 2014
  #################
  def update
  
 # raise params.inspect
  case params[:eventable_type] 
    
    when "Group"
    
        @amzurevent = AmzurEvent.find(params[:id])
        @amzurevent.update(:title =>params[:amzur_event][:title], :description=>params[:amzur_event][:description], :held_on=>params[:amzur_event][:held_on], :eventable_type=> params[:eventable_type],  :eventable_id => params[:group_id], :is_send_mail=>params[:amzur_event][:is_send_mail] )
        
        if @amzurevent
          if @amzurevent.is_send_mail
             Group.find(params[:group_id]).employees.where(status: false).each do |emp|
            Notification.delay.event_notification(emp.user,@amzurevent)
          end
        end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "edit"
       end
    
    when "Department"
    #raise amzurevent_params.inspect
      @amzurevent = AmzurEvent.find(params[:id])
      @amzurevent.update(:title =>params[:amzur_event][:title], :description=>params[:amzur_event][:description], :held_on=>params[:amzur_event][:held_on], :eventable_type=> params[:eventable_type], :eventable_id => params[:department_id], :is_send_mail=>params[:amzur_event][:is_send_mail] )
    
      if @amzurevent
        if @amzurevent.is_send_mail
          Department.find(params[:department_id]).employees.where(status: false).each do |emp|
          Notification.delay.event_notification(emp.user,@amzurevent)
        end
      end
      redirect_to amzur_events_path
     else
      flash.now[:error]
      render "edit"
     end
      
    when "Workgroup"
    #raise  params.inspect
         @amzurevent = AmzurEvent.find(params[:id])
         @amzurevent.update(:title =>params[:amzur_event][:title], :description=>params[:amzur_event][:description], :held_on=>params[:amzur_event][:held_on], :eventable_type=> params[:eventable_type], :eventable_id => params[:workgroup_id], :is_send_mail=>params[:amzur_event][:is_send_mail] )
    
        if @amzurevent
          if @amzurevent.is_send_mail
             Workgroup.find(params[:workgroup_id]).employees.where(status: false).each do |emp|
            Notification.delay.event_notification(emp.user,@amzurevent)
           end
        end
        redirect_to amzur_events_path
       else
        flash.now[:error]
        render "edit"
       end
    else 
       @amzurevent = AmzurEvent.find(params[:id])
       @amzurevent.update(:title =>params[:amzur_event][:title], :description=>params[:amzur_event][:description], :held_on=>params[:amzur_event][:held_on], :eventable_type=> params[:eventable_type], :eventable_id => params[:eventable_id], :is_send_mail=>params[:amzur_event][:is_send_mail] )
      if @amzurevent
        if @amzurevent.is_send_mail
          Employee.where(status: false).each do |emp|
          Notification.delay.event_notification(emp.user,@amzurevent)
        end
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
  
 
  
  
  private
  
  def amzurevent_params
     params.require(:amzur_event).permit(:title, :description, :held_on, :is_send_mail) 
  end
  
  def find_event
    @amzurevent = AmzurEvent.find(params[:id])
  end
  
end
