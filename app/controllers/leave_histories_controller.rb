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
  
  def create 
    #raise params.inspect
    @employee = current_user.employee
    leave_type_id = params[:leave_history][:leave_type_id].to_i
    #raise params.inspect
    # startenddate(leave_type_id)
    if leave_type_id == 2
      @leave_history = current_user.employee.leave_histories.new(params_leave_history)
      #raise params.inspect
      date = params[:float_leave_date]
      start_date, end_date = startenddate(date)
      #raise start_date.inspect
      #raise end_date.inspect
      flag = 0
      leave_records = @employee.leave_histories.where(leave_type_id: 2)
        if leave_records.present?
        leave_records.each do |leave|
          if (start_date.to_date .. end_date.to_date).include?(leave.from_date.to_date)
          #raise params.inspect
      flag = 1
      break
      #render action: 'new' , :locals => { :@error => "Already You Applied " }
          end
      end
    end
      if flag == 1
        render action: 'new' , :locals => { :@error => "Already You Applied for Floating Holiday" }
      else
        @leave_history = current_user.employee.leave_histories.create(params_leave_history)
        total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
        weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)  
        applied_days = total_days - weekend_count
        @leave_history.update(:days => applied_days)
        Notification.delay.applyleave(current_user.employee, @leave_history)
        redirect_to leave_histories_path 
    end
        #raise end_date.inspect
=begin
        if value == true 
         @leave_history = LeaveHistory.new
        #render "new", :locals => { :@error => "Already You Applied " }
        else 
        startenddate(date)
          @leave_history = current_user.employee.leave_histories.create(params_leave_history)
          total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
          weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)  
          applied_days = total_days - weekend_count
          @leave_history.update(:days => applied_days)
          Notification.delay.applyleave(current_user.employee, @leave_history)
          redirect_to leave_histories_path
        end
=end
        #redirect_to leave_histories_path
        #raise value.inspect
        #leave_type = float_leave(leave_type_id)  
       # raise leave_type.inspect
=begin      flag = 0
      @leaves = LeaveHistory.where(employee_id: @employee.id).collect{|leave| (leave.from_date.to_date..leave.to_date.to_date).to_a}.flatten!
      (params[:leave_history][:from_date].to_date..params[:leave_history][:to_date].to_date).each do |date|
        if @leaves.present? && @leaves.include?(date)
          flag = 1
          @applied_date = date
          break
         end
        end
        if flag == 1
          @leave_history = LeaveHistory.new
          
        end 
=end  
		else 
		   if params[:leave_history][:is_halfday] == "full_day"
          @leave_history = current_user.employee.leave_histories.create(params_leave_history)
          total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
          weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)  
          applied_days = total_days - weekend_count 
          @leave_history.update(:days => applied_days)
          Notification.delay.applyleave(current_user.employee, @leave_history)
       else
          if params[:leave_date].present?
          @leave_history = current_user.employee.leave_histories.create(:from_date =>params[:leave_date], :to_date =>params[:leave_date], :section => params[:leave_history][:section], :reason => params[:leave_history][:reason], :leave_type_id => params[:leave_history][:leave_type_id], :is_halfday => true)  
          @leave_history.update(:days => 0.5) 
          # @employee.leave.update(available_leaves: a_leaves - 0.5 )
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
   ###
   if params[:leave_history][:is_halfday] == "full_day"
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

