class LeavePoliciesController < ApplicationController

 def index
   @group = Group.find(params[:group_id])
   @leave_policy = @group.leave_policy
   #raise @leave_policy.inspect
 end
 
 def new
   @group = Group.find(params[:group_id])
   @leave_policy = LeavePolicy.new
   
 end
 
 def create
  #raise params.inspect@group = Group.create(params[:group_name])
   @group = Group.find(params[:group_id])
   @leave_policy = LeavePolicy.create(params_leavepolicy)
   @leave_policy.group_id = params[:group_id]
   @leave_policy.save
   redirect_to group_path(@group)
   
   
 end
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves)
  end
 
end
