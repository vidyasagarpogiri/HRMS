class AppraisalCyclesController < ApplicationController
  
  def index
    @appraisal_cycles = AppraisalCycle.all
  end
  #author: sekhar
  #date: 21/11/2014
  # this actiion is for new  AprisalCycle 
  def new
    @appraisal_cycle = AppraisalCycle.new
  end
  
  def create
    @appraisal_cycle =  AppraisalCycle.create(appraisal_cycle_params)
    redirect_to appraisal_cycles_path
  end
  
  def show
  end
  
  private
  
  def appraisal_cycle_params
    params.require(:appraisal_cycle).permit(:title, :department_id, :start_date, :end_date, :period, :employee_dead_line, :manager_dead_line, :discussion_dead_line, :status)
  end
end
