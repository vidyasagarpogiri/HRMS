class LeavePoliciesController < ApplicationController

 def index
   @leave_policies = LeavePolicies.all
   
 end
 
 def new
   @employee = Employee.find(params[:employee_id])
   @group = Group.find(params[:group_id])
   @leave_policy = LeavePolicy.new
   
 end
 
 def create
   @employee = Employee.find(params[:employee_id])
   @group = Group.create(params[:group_name])
   @leave_policy = LeavePolicies.create( params_leavepolicy)
   redirect_to 
   
   
 end
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves)
  end
 
end
