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
    @group = Group.create(group_params)
    redirect_to  @group
  end
  
  def show
    
     @group = Group.find(params[:id])
      
  end
  
  private
  def group_params
     params.require(:group).permit(:group_name)
     #params.require(:leave_policy).permit( :pl_per_year, :sl_per_year, :eligible_carry_forward_leaves)
  end
  
  
end
