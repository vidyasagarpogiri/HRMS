class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end
  
  def new
    
    @group = Group.new
   # @group.leave_policy.build
   
    
  end
  
  def create
    #raise params.inspect 
    
    @group = Group.create(params[:group_name])
    redirect_to  new_group_leave_policy_path(@group)
  end
  
  private
  def group_params
     params.require(:group).permit(:group_name)
     #params.require(:leave_policy).permit( :pl_per_year, :sl_per_year, :eligible_carry_forward_leaves)
  end
  
  
end
