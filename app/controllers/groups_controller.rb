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
     @reporting_manager = ReportingManager.find_by
  end          
           
                                                                                                                   
     
