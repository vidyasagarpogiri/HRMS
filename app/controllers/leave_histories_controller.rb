class LeaveHistoriesController < ApplicationController

  layout "leave_template"
 	
 include ApplicationHelper

	def index
		@leaves = current_user.employee.leave_histories
		@employee = current_user.employee
	end



  def new
    @employee = current_user.employee
    @leave_history = LeaveHistory.new
  end
  
  
  def show

  end
  
 
  def create
   @leave_history = current_user.employee.leave_histories.create(params_leave_history)
   
   total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_i + 1
    
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date)
  
    applied_days = total_days - weekend_count 
   #raise applied_days.inspect 
   @leave_history.update(:days => applied_days)
   Notification.applyleave(current_user.employee, @leave_history).deliver
   redirect_to leave_histories_path
  end
  
  
  def edit
   @leave_history = LeaveHistory.find(params[:id])
  end
  
  def update
  
    @leave_history = LeaveHistory.find(params[:id])
    @leave_history.update(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_i + 1
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date)
    applied_days = total_days - weekend_count  
   @leave_history.update(:days => applied_days)
    redirect_to employee_leave_histories_path
  end
  
  
  def applied_leaves
		@leave_histories = LeaveHistory.all
	end
	

	
	def reported_leaves
		@reporting_manager = current_user.employee.reporting_managers.first
		@group = @reporting_manager.group
	  @employees = @group.employees	
	end
		
	def accept
		
		@employee = Employee.find(params[:employee_id])
		@leave_history = LeaveHistory.find(params[:leave_history_id])
		@leave_history.update(:status => LeaveHistory::APPROVED)
		@leave_type = @leave_history.leave_type
		@leave = @employee.group.leave_policy
		 Notification.accept_leave(current_user.employee, @leave_history).deliver
		redirect_to reported_leaves_path

	end

	
	def reject
		#raise params.inspect
		@leave_history = LeaveHistory.find(params[:leave_history_id])
		@leave_history.update(:status => LeaveHistory::REJECTED)
		 Notification.reject_leave(current_user.employee, @leave_history).deliver
		redirect_to reported_leaves_path
	end

   def employee_leaves
    @leaves = LeaveHistory.all
   end

	private
  
  def params_leave_history
    params.require(:leave_history).permit(:from_date, :to_date, :reason, :feedback, :leave_type_id, :subject)
  end

end

