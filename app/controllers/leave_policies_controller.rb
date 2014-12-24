class LeavePoliciesController < ApplicationController
 before_filter :hr_view,  only: ["new", "edit"]
 before_filter :other_emp_view
 before_action :get_group, only: [:index, :new, :create, :edit, :update]
 
 def index
   @leave_policy = @department.leave_policy
 end
 
 def new
  @leave_policy = LeavePolicy.new
   
 end
 
 def create
   @leave_policy = LeavePolicy.create(params_leavepolicy)
   @leave_policy.group_id = params[:group_id]
   @leave_policy.save
  @errors = @leave_policy.errors.full_messages
 end
	

 def edit
  @leave_policy = @group.leave_policy
 end
 
 def update
  @leave_policy = @group.leave_policy
  @leave_policy.update(params_leavepolicy)
  @errors = @leave_policy.errors.full_messages
 end
 
 private
 
 def params_leavepolicy
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves, :max_carry_forward_leaves)
 end

 def get_group
  @group = Group.find(params[:group_id])
 end 
 
end
