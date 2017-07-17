class GroupsController < ApplicationController

  layout "leave_template"
  
  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
                 
  def index
    @groups = Group.all
  end
  
  def new
    @group = Group.new
    @employee = Employee.new
    #raise params.inspect
    @reporting_manager = ReportingManager.new
  end
 
  def create
    @employee = Employee.find(params[:emp_id]) 
    @group = Group.create(group_params)
    @reporting_manager = ReportingManager.create(:employee_id => @employee.id, :group_id => @group.id)
    redirect_to  @group
  end                                                                                                    
                                                
  def show                                       
     @group = Group.find(params[:id])
     @employee = @group.reporting_manager.employee
     @leave_policy = @group.leave_policy
     @holiday_calenders = @group.holiday_calenders
  end
  
  def edit
     @group = Group.find(params[:id])
     @reporting_manager = ReportingManager.find_by(@group.id)
     @employee = Employee.find_by(@reporting_manager.id)
  end
              
  def update                   
    @group = Group.find(params[:id])                        
    @group.update(group_params)
    @employee = Employee.find(params[:emp_id])
    @reporting_manager = ReportingManager.find_by(@group.id)
    @reporting_manager.update(:employee_id => @employee.id)
    redirect_to  @group
  end             
  
  def add_employee
    @group = Group.find(params[:id])
    @employees = Employee.all    
  end
  
  def update_add_employee
     @group = Group.find(params[:id])
     @employee = Employee.find(params[:employee_id])      
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
  end
  
  
end            
