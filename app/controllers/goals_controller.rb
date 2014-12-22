class GoalsController < ApplicationController
  
  def index
    @goals = Goal.all
  end
  
  def new
    @goal = Goal.new
  end
  
  def create
  raise params.inspect
    @goal = Goal.create(goal_params)
    redirect_to goals_path
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:title, :description, :start_date, :end_date)
  end
end
