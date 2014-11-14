class LeaveTypesController < ApplicationController
 before_filter :hr_view,  only: ["new", "edit"]
 before_filter :other_emp_view
 
  def index
    @leave_types = LeaveType.all
  end
  
  def new
    @leave_type = LeaveType.new
  end
  
  def create
    @leave_type = LeaveType.create(params_leave_types)
    @leave_type.save
    redirect_to leave_types_path
  end
  
  def edit
    @leave_type = LeaveType.find(params[:id])
  end
  
  def update
    @leave_type = LeaveType.find(params[:id])
    @leave_type.update(parama_leave_types)
    redirect_to leave_types_path
  end
  
  def show    
  end
  
  def destroy
  @leave_type = LeaveType.find(params[:id])
  @leave_type.destroy
  redirect_to leave_types_path  
  end
  
  private
  
  def params_leave_types
    params.require(:leave_type).permit(:type_name)
  end
  
end
