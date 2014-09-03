class LeavePoliciesController < ApplicationController

 def index
   @leave_policies = LeavePolicies.all
   
 end
 
 def new
   @group = Group.find(params[:group_id])
   @leave_policy = LeavePolicy.new
   
 end
 
 def create
   @group = Group.create(params[:group_name])
   @leave_policy = LeavePolicies.create( params_leavepolicy)
   redirect_to 
   
   
 end
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves)
  end
 
end
