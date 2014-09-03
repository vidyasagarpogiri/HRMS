class LeavePoliciesController < ApplicationController

 def index
   @leave_policies = LeavePolicies.all
   
 end
 
 def new
   @group = Group.find(params[:group_id])
   @leave_policy = LeavePolicy.new
   
 end
 
 def create
  #raise params.inspect@group = Group.create(params[:group_name])
   @group = Group.find(params[:group_id])
   @leave_policy = LeavePolicies.create(params_leavepolicy)
   @leave_policy.update(:group_id => params[:group_id])
   redirect_to group_path(@leave_policy)
   
   
 end
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves)
  end
 
end
