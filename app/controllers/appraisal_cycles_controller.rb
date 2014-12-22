class AppraisalCyclesController < ApplicationController
  def index
    @appraisal_cycles = AppraisalCycle.all
  end

  # author: sekhar
  # date: 21/11/2014
  # this actiion is for new  AprisalCycle
  def new
    @appraisal_cycle = AppraisalCycle.new
  end

  def create
    @appraisal_cycle =  AppraisalCycle.create(appraisal_cycle_params)
    @appraisal_cycles = AppraisalCycle.all
  end

  def status_update
    @appraisal_cycle =  AppraisalCycle.find(params[:id])
    @appraisal_cycle.update(status: params[:appraisal_cycle_status])
    @appraisal_cycle.employees_appraisal_lists.update_all(status:  AppraisalCycle::CLOSE)
    @appraisal_cycles = AppraisalCycle.all
  end

  def show
    @appraisal_cycle = AppraisalCycle.find(params[:id])
    @appraisals = @appraisal_cycle.employees_appraisal_lists
  end
  
  def appraisal_status_update
    employee_appraisal = EmployeesAppraisalList.find(params[:id])
    employee_appraisal.update(status: Appraisal::REVIEW)
    @appraisals = employee_appraisal.appraisal_cycle.employees_appraisal_lists
  end

  private

  def appraisal_cycle_params
    params.require(:appraisal_cycle).permit(:title, :department_id, :start_date, :end_date, :period, :employee_dead_line, :manager_dead_line, :discussion_dead_line).merge(status: AppraisalCycle::OPEN)
  end
end
