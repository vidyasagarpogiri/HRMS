class GroupsController < ApplicationController

    layout "leave_template"
  
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
    @reporting_manager = ReportingManager.create(:employee_id => @employee.id, :group_id => @group.id)
    #raise @reporting_manager.inspect
    redirect_to  @group
  end
  
  def show
     #raise params.inspect
     @group = Group.find(params[:id])
     @employee = @group.reporting_manager.employee
     @leave_policy = @group.leave_policy
     @holiday_calenders = @group.holiday_calenders
     
  end
  
  def edit
     #raise params.inspect
     @group = Group.find(params[:id])
     @reporting_manager = ReportingManager.find_by(@group.id)
     @employee = Employee.find_by(@reporting_manager.id)
     #raise @employee.inspect     
  end
  
  def update
   #raise params.inspect
    @group = Group.find(params[:id])
    @group.update(group_params)
    #raise @group.inspect #update(group_params)
    @employee = Employee.find(params[:emp_id])
    #raise @employee.id.inspect
    @reporting_manager = ReportingManager.find_by(@group.id)
    #raise @reporting_manager.inspect
    @reporting_manager.update(:employee_id => @employee.id)
    #raise @reporting_manager.inspect
   redirect_to  @group
     
  end
  
  def add_employee
    @group = Group.find(params[:id])
    @employees = Employee.all    
  end
  
  def update_add_employee
      #raise params.inspect
      @group = Group.find(params[:id])
      @employee = Employee.find(params[:employee_id])
      #raise @employee.inspect
      @employee.update(:group_id => @group.id)
      redirect_to @group
  end

	def holiday_list
		@holidays = current_user.employee.group.holiday_calenders
		@leave_policy = current_user.employee.group.leave_policy
		@group = current_user.employee.group
	end
  
  private
  def group_params
     params.require(:group).permit(:group_name)
     #params.require(:leave_policy).permit( :pl_per_year, :sl_per_year, :eligible_carry_forward_leaves)
  end
  
  
end
