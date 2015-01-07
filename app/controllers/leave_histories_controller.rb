class LeaveHistoriesController < ApplicationController
 #before_filter :hr_view,  only: ["new", "edit"]
# before_filter :other_emp_view
 	
 include ApplicationHelper
 include LeaveHistoriesHelper
	
	def index
		@leave = current_user.employee.group.leave_policy if current_user.employee.group.present?
		@leaves = current_user.employee.leave_histories.where(:status => 'HOLD').order('created_at DESC')
		@leave_histories = current_user.employee.leave_histories.order('created_at DESC')
		@employee = current_user.employee
		@holiday_calenders = current_user.employee.group.holiday_calenders if current_user.employee.group.present?
		@reported_leaves = ReportingManager.where(:manager_id => current_user.employee.id).order('created_at DESC')
		@employees=ReportingManager.where(:manager_id => current_user.employee.id).map(&:employee)
	end
  
  def reportees_leaves   
   @reported_leaves = ReportingManager.where(:manager_id => current_user.employee.id).order('created_at DESC')   
   @employees=ReportingManager.where(:manager_id => current_user.employee.id).map(&:employee)
  end

  def new
    @employee = current_user.employee
    @leave_history = LeaveHistory.new
    @leaves = LeaveHistory.where(employee_id: @employee.id).collect{|leave| (leave.from_date.to_date..leave.to_date.to_date).to_a}.flatten!
  end
  
  def show
  end
  
  # author: sekhar
  # Action is to create leave record for an employee leave request
  # don`t delete comments 
  def create 
    @employee = current_user.employee
    leave_type_id = params[:leave_history][:leave_type_id].to_i
    # condition checking for leave type i.e personal leave or floating leave
    if leave_type_id == 2
      # code for create float leave
      @leave_history = current_user.employee.leave_histories.new(params_leave_history)
      date = params[:float_leave_date]
      # method will return start date and date of quarter/half/year of given date
      # depends on floating leave policy
      start_date, end_date = startenddate(date)
      flag = 0 # boolean variable for condition checking
      leave_records = @employee.leave_histories.where(leave_type_id: 2)
        if leave_records.present? # condition for leave records of floating leave present or not
          leave_records.each do |leave| # loop for leave records
            # condition will check leave record date already present in start and end dates of applied date
            if (start_date.to_date .. end_date.to_date).include?(leave.from_date.to_date)
              flag = 1 # value will assign to 1 when above condition returns true
              break
          end
        end
      end
      if flag == 1
        # if above condition returns true
        # it will render new form again with a warning message
        render action: 'new' , :locals => { :@error => "Already You Applied for Floating Holiday" }
      else
        # will create leave record for floating leave
        leave_date = params[:float_leave_date]
        @leave_history = current_user.employee.leave_histories.create(from_date: leave_date, to_date: leave_date, reason: params[:leave_history][:reason], leave_type_id: params[:leave_history][:leave_type_id]) 
        # need to check this code from below line  
        # calculations of total days 
        total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
        weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)  
        applied_days = total_days - weekend_count
        # to above line
        @leave_history.update(:days => applied_days)
        # will send mail to reporting manager
        Notification.delay.applyleave(current_user.employee, @leave_history)
        redirect_to leave_histories_path # will redirect to leavehistiories index page
      end 
		else 
		  # code is for creating full day or half day leave
		  # condition to check applied leave full day or not
		  if params[:leave_history][:is_halfday] == "full_day"
		    # if full day will create a leave record for more than one day
        @leave_history = current_user.employee.leave_histories.create(params_leave_history)
        # calculation for total days
        total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
        # calculation of weekends in the applied dates
        weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)  
        # calculation of leave applied days
        applied_days = total_days - weekend_count 
        @leave_history.update(:days => applied_days)
        # will send mail to reporting manager
        Notification.delay.applyleave(current_user.employee, @leave_history)
      else
        # code for half day
        if params[:leave_date].present?
          # leave record will create for half day leave
          @leave_history = current_user.employee.leave_histories.create(:from_date =>params[:leave_date], :to_date =>params[:leave_date], :section => params[:leave_history][:section], :reason => params[:leave_history][:reason], :leave_type_id => params[:leave_history][:leave_type_id], :is_halfday => true)  
          @leave_history.update(:days => 0.5) 
          Notification.delay.applyleave(current_user.employee, @leave_history)
          end
        end
		    redirect_to leave_histories_path
		  end
  end
    
  def edit
   @employee = current_user.employee
   @leave_history = LeaveHistory.find(params[:id]) 
  end
  
  def update
   #raise params.inspect
   @leave_history = LeaveHistory.find(params[:id])
   @employee = @leave_history.employee
   #Checking Wehter Leave already apporved or not if apporved then we added days to leaves avialalbe days
    if @leave_history.status == LeaveHistory::APPROVED
      @days =  @leave_history.days   
    end
    leave_type_id = params[:leave_history][:leave_type_id].to_i
   # For floating leave edit
   if  leave_type_id == 2 && params[:leave_history][:is_halfday] == "full_day" 
    #raise params.inspect
    date = params['float_leave_date']
    start_date, end_date = startenddate(date)
    @leave_history.update(:from_date =>date, :to_date =>date, :reason => params[:leave_history][:reason])
    Notification.delay.applyleave(current_user.employee, @leave_history)
   ###
   elsif params[:leave_history][:is_halfday] == "full_day"
    @leave_history.update(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, @employee.group)
    applied_days = total_days - weekend_count  
    @leave_history.update(days: applied_days, status: LeaveHistory::HOLD)
    Notification.delay.applyleave(current_user.employee, @leave_history)
   else
    @leave_history.update(:from_date =>params[:leave_date], :to_date =>params[:leave_date], :section => params[:leave_history][:section], :reason => params[:leave_history][:reason], :leave_type_id => params[:leave_history][:leave_type_id], :is_halfday => true)
    @leave_history.update(:days => 0.5, status: LeaveHistory::HOLD)     
    @days ||= 0
    a_leaves = Leave.employee_available_leaves(@employee)
    @employee.leave.update(available_leaves: a_leaves + @days )
    Notification.delay.applyleave(current_user.employee, @leave_history)
   end
    redirect_to leave_histories_path
  end
    
  def applied_leaves
		@leave_histories = LeaveHistory.all.page(params[:page]).per(2)
	end
	
  def reported_leaves
	  if current_user.employee.reporting_manager.present?
		@reported_leaves = ReportingManager.where(:manager_id => current_user.employee.id)
		else
		redirect_to leave_histories_path
		end
	end
		
	def accept
		@employee = Employee.find(params[:employee_id])
		@leave_history = LeaveHistory.find(params[:leave_history_id])
		@leave_history.update(:status => LeaveHistory::APPROVED)
		#BalaRaju Updates Availabe Days into Leave Table
    a_leaves = Leave.employee_available_leaves(@employee)
    @employee.leave.update(available_leaves: a_leaves - @leave_history.days )
    #
		@leave_type = @leave_history.leave_type
		Notification.delay.accept_leave(@employee, @leave_history)
	  @reported_leaves = ReportingManager.where(:manager_id => current_user.employee.id)
	end

	
	def reject
		@leave_history = LeaveHistory.find(params[:id])
		@leave_history.update(:status => LeaveHistory::REJECTED, :feedback => params[:leave_history][:feedback])
		Notification.delay.reject_leave(current_user.employee, @leave_history)
		@reported_leaves = ReportingManager.where(:manager_id => current_user.employee.id)		
	end

  def employee_leaves
    @leaves = LeaveHistory.all
  end
   
  def reported_employees
    @employees=ReportingManager.where(:manager_id => current_user.employee.id).map(&:employee)
  end
  
  def destroy
    @leave_history = LeaveHistory.find(params[:id])
    @leave_history.destroy
    redirect_to leave_histories_path
  end

  def getLeaveForm
    @leave = LeaveHistory.find(params[:id]) 
  end

	private
  
  def params_leave_history
    params.require(:leave_history).permit(:from_date, :to_date, :reason, :feedback, :leave_type_id)
  end
end

