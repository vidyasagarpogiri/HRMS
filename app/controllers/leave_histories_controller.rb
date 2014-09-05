class LeaveHistoriesController < ApplicationController

  def index
    @leave_histories = LeaveHistoties.all
  end
  
  def new
    @employee = Employee.find(params[:employee_id])
    @leavetype = LeaveTypes.find(params[:leave_type_id])
    @leavehistory = LeaveHistoties.new
  end
  
  def create
    @employee = Employee.find(params[:employee_id])
    @leavetype = LeaveTypes.find(params[:leave_type_id])
    @leavehistory = LeaveHistoties.create(params_leavehistory)  
  end
  
  def show
  end
  
  private
  def params_leavehistory
    params.require(:leave_history).permit(:from_date, :to_date, :days, :reason, :feedback, :leave_type_id, :employee_id)
  end

  #raise params.inspect
   @employee = Employee.find(params[:employee_id])
   #raise @employee.inspect
   @leave_history = LeaveHistory.where(:employee_id => @employee.id)
  #raise @leave_history.inspect 
  end
  
  def new
  #raise params.inspect
  @employee = Employee.find(params[:employee_id])
  @leave_history = LeaveHistory.new
  end
  
  def create
   # raise params.inspect
   @employee = Employee.find(params[:employee_id])
   @leave_history = LeaveHistory.create(params_leave_history)
   @leave_history.employee_id = params[:employee_id]
   @leave_history.save
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
  
  
  
  
  private 
  
  def params_leave_history
     params.require(:leave_history).permit(:from_date, :to_date, :days, :leave_type_id, :reason, :feedback)
  end
  
end  

