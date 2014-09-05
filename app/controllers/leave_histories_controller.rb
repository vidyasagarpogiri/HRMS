class LeaveHistoriesController < ApplicationController
 	

	def index
		
		@employee = Employee.find(params[:employee_id])

		@leaves = @employee.leave_histories

	end
	
  def new
    @employee = Employee.find(params[:employee_id])
    #@leave_type = LeaveTypes.find(params[:leave_type_id])
    @leave_history = LeaveHistory.new
  end
  
  
  def show
  end
  
 
  def create
   # raise params.inspect
   @employee = Employee.find(params[:employee_id])
   @leave_history = LeaveHistory.create(params_leave_history)
   @leave_history.employee_id = params[:employee_id]
   @leave_history.update(:status => "hold")
   redirect_to employee_leave_histories_path
  end
  
  
  def edit
  #raise params.inspect
   @employee = Employee.find(params[:employee_id])
   @leave_history = LeaveHistory.find(params[:id])
  end
  
  def update
  
    @employee = Employee.find(params[:employee_id])
    @leave_history = LeaveHistory.find(params[:id])
    @leave_history.update(params_leave_history)
    redirect_to employee_leave_histories_path
  end
  
  
  def applied_leaves
		#@employee = Employee.find(params[:employee_id])
		@leave_histories = LeaveHistory.all
		#raise @leave_histories.inspect
	end
	

	
	def reported_leaves
	
		@group = current_user.employee.group
				
	@employees = @group.employees	
		
	end



	private
  def params_leave_history
    params.require(:leave_history).permit(:from_date, :to_date, :days, :reason, :feedback, :leave_type_id, :employee_id)
  end
  
end

