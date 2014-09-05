class GroupsController < ApplicationController

  def index
    @groups = Group.all
    
  end
  
  def new
    
    @group = Group.new
    @employee = Employee.new
    @reporting_manager = ReportingManager.new
   # @group.leave_policy.build
   
    
  end
  
  def create
    #raise params.inspect
    @employee = Employee.find(params[:emp_id]) 
    #raise @employee.inspect
    @group = Group.create(group_params)
    @reporting_manager = ReportingManager.create(:employee_id => @employee.id)
    #raise @reporting_manager.inspect
    redirect_to  @group
  end
  
  def show
     #raise params.inspect
     @group = Group.find(params[:id])
     @leave_policy = @group.leave_policy
     @holiday_calanders =HolidayCalender.where(:group_id => @group.id)
     
  end
  
  private
  def group_params
     params.require(:group).permit(:group_name)
     #params.require(:leave_policy).permit( :pl_per_year, :sl_per_year, :eligible_carry_forward_leaves)
  end
  
  
end
