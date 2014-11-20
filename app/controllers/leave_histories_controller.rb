class LeaveHistoriesController < ApplicationController
 #before_filter :hr_view,  only: ["new", "edit"]
# before_filter :other_emp_view
 	
 include ApplicationHelper
  before_action :leave_check, only: [:create, :update]
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
    @employee = current_user.employee
    if params[:leave_history][:is_halfday] == "full_day"
    @leave_history = current_user.employee.leave_histories.create(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)  
    applied_days = total_days - weekend_count 
    @leave_history.update(:days => applied_days) 
    Notification.delay.applyleave(current_user.employee, @leave_history)
    else
        @leave_history = current_user.employee.leave_histories.create(:from_date =>params[:leave_date], :to_date =>params[:leave_date], :section => params[:leave_history][:section], :reason => params[:leave_history][:reason], :leave_type_id => params[:leave_history][:leave_type_id], :is_halfday => true)
      @leave_history.update(:days => 0.5) 
      Notification.delay.applyleave(current_user.employee, @leave_history)
    end
		redirect_to leave_histories_path
  end
    
  def edit
   @employee = current_user.employee
   @leave_history = LeaveHistory.find(params[:id]) 
  end
  
  def update
   @leave_history = LeaveHistory.find(params[:id])
   if params[:leave_history][:is_halfday] == "full_day"
    @leave_history.update(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_f + 1.0
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date, current_user.employee.group)
    applied_days = total_days - weekend_count  
    @leave_history.update(:days => applied_days)
    @leave_history.update(:status => LeaveHistory::HOLD)
    Notification.delay.applyleave(current_user.employee, @leave_history)
   else
    @leave_history.update(:from_date =>params[:leave_date], :to_date =>params[:leave_date], :section => params[:leave_history][:section], :reason => params[:leave_history][:reason], :leave_type_id => params[:leave_history][:leave_type_id], :is_halfday => true)
    @leave_history.update(:days => 0.5) 
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

