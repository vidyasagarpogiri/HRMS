class LeavePoliciesController < ApplicationController

 def index
   @leave_policies = LeavePolicies.all
   
 end
 
 def new
   @leave_policy = LeavePolicies.new
   
 end
 
 def create
   @leave_policy = LeavePolicies.create( params_leavepolicy)
 end
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_per_year, :sl_per_year, :eligible_carry_forward_leaves)
  end
 
end
