class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end
  
  def new
    @group = Group.new
    
  end
  
  def create
    @group = Group.create(params[:group_name])
  end
  
  private
  def group_params
 
  end
  
end
