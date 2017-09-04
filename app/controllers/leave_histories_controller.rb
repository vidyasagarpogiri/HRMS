class LeaveHistoriesController < ApplicationController
	
  #before_filter :hr_view,  only: ["new", "edit"]
  #before_filter :other_emp_view              
	                   
  layout "leave_template"                  
 	                                                 
 include ApplicationHelper
          
def index
  @leave =current_user.employee.department.leave_policy
  @leaves = current_user.employee.leave_histories.where(:status => 'HOLD').page(params[:page]).per(4)
  @leave_histories = current_user.employee.leave_histories.where("status != ?", "HOLD" ).page(params[:page]).per(4)
  @employee = current_user.employee
end                   

  def new
   @employee = current_user.employee
   @leave_history = LeaveHistory.new
  end
                                 
  def show                                            
  #raise params.inspect                                                                   
  end                      
                                    
  def create                                               
    #raise params.inspect
    @employee = current_user.employee
    @leave_history = current_user.employee.leave_histories.new(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_i + 1
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date)  
    applied_days = total_days - weekend_count 
    #--TODO----- leave balance alert before save
    @leave_history.save                                           
    @leave_history.update(:days => applied_days)         
    Notification.applyleave(current_user.employee, @leave_history).deliver
redirect_to leave_histories_path          
#else                                                                         
  #flash[:notice]= "no leave policy for you"                                                                                                      
#render 'new'                        
#	end
  end    
  
  
  def edit
  #raise params.inspect
   @leave_history = LeaveHistory.find(params[:id])
   
  end
  
  def update
    @leave_history = LeaveHistory.find(params[:id])
    @leave_history.update(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_i + 1
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date)
    applied_days = total_days - weekend_count  
    @leave_history.update(:days => applied_days)
    @leave_history.update(:status => LeaveHistory::HOLD)
    Notification.applyleave(current_user.employee, @leave_history).deliver
    redirect_to leave_histories_path
  end
  
  
  def applied_leaves
    @leave_histories = LeaveHistory.all.page(params[:page]).per(2)
  end
	

	
	def reported_leaves
	  #raise params.inspect
	  if current_user.employee.reporting_manager.present?
		@reported_leaves = ReportingManager.where(:manager_id => current_user.employee.id).page(params[:page]).per(2)
		else
		redirect_to leave_histories_path
		end
    #raise @reported_leaves.inspect
  
	end
		
	def accept
		#raise params.inspect
		@employee = Employee.find(params[:employee_id])
		@leave_history = LeaveHistory.find(params[:leave_history_id])
		@leave_history.update(:status => LeaveHistory::APPROVED)
		@leave_type = @leave_history.leave_type
		#@leave = @employee.group.leave_policy
		Notification.accept_leave(@employee, @leave_history).deliver
		redirect_to reported_leaves_path

	end

	
	def reject

		@leave_history = LeaveHistory.find(params[:id])
		@leave_history.update(:status => LeaveHistory::REJECTED, :feedback => params[:leave_history][:feedback])
		 Notification.reject_leave(current_user.employee, @leave_history).deliver

		redirect_to reported_leaves_path
	end

  def employee_leaves
    @employee = current_user.employee.department
    @leaves = LeaveHistory.order('created_at DESC').page(params[:page]).per(2)
   end
   
  def reported_employees
    @employees=ReportingManager.where(:manager_id => current_user.employee.id).map(&:employee)

  end
  
  def destroy
  #raise params.inspect
  @leave_history = LeaveHistory.find(params[:id])
  @leave_history.destroy
  redirect_to leave_histories_path
  
  end

  def getLeaveForm
    #raise params.inspect 
    @leave = LeaveHistory.find(params[:id])
	 
  end   

	private
  
  def params_leave_history
    params.require(:leave_history).permit(:from_date, :to_date, :reason, :feedback, :leave_type_id)
  end

end

