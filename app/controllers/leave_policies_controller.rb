class LeavePoliciesController < ApplicationController
 before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
#  layout "leave_template"

 def index
   @group = Group.find(params[:group_id])
   #@department = Department.find(params[:department_id])
   @leave_policy = @department.leave_policy
   
   
   #raise @leave_policy.inspect
 end
 
 def new
  @group = Group.find(params[:group_id])
  #@department = Department.find(params[:department_id])
  @leave_policy = LeavePolicy.new
   
 end
 
 def create
	 @group = Group.find(params[:group_id])
  #@department = Department.find(params[:department_id])
   @leave_policy = LeavePolicy.create(params_leavepolicy)
   #@leave_policy.department_id = params[:department_id]
   @leave_policy.group_id = params[:group_id]
   @leave_policy.save
  @errors = @leave_policy.errors.full_messages
 end
	

 def edit
 @group = Group.find(params[:group_id])
 #@department = Department.find(params[:department_id])
  @leave_policy = @group.leave_policy
 end
 
 def update
  @group = Group.find(params[:group_id])
 # @department = Department.find(params[:department_id])
  #@leave_policy = @department.leave_policy
  @leave_policy = @group.leave_policy
  @leave_policy.update(params_leavepolicy)
  @errors = @leave_policy.errors.full_messages
 end
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves)
  end
 
end
