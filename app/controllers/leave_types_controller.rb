class LeaveTypesController < ApplicationController

  def index
    @leavetypes = LeaveTypes.all
  end
  
  def new
    @leavetype = LeaveTypes.new
    @group = Group.find(params[:group_id])
  end
  
  def create
    @group = Group.find(params[:group_id])
    @leavetype = LeaveTypes.create(params.require[:leave_types].permit(:type_name))
  end
  
  def edit
    @group = Group.find(params[:group_id])
    @leavetype = LeaveTypes.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:group_id])
    @leavetype = LeaveTypes.find(params[:id])
    @leavetype.update(params.require[:leave_types].permit(:type_name))
  end
  
  def show
    
  end
  
end
