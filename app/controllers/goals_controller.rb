class GoalsController < ApplicationController
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.create(goal_params)
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:title, :description, :start_date, :end_date)
  end
end
