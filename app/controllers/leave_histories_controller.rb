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
end
