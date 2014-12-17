# Author: sekhar
class AppraisalsController < ApplicationController
  # to use application helper module methods
  include ApplicationHelper
  # to create appraisal list and employees list
  before_action :create_assign_list, only: [:create_appraisal, :assign_employee_appraisals]
  # will get current employee before going those actions in the array of actions
  before_action :find_current_user, only: [:employee_appraisal_form, :create_employee_appraisal, :employee_appraisals, :indivisual_appraisals]
  before_action :appraisals_list, only: [:hr_manager_view, :employee_appraisal_view, :reportee_appraisal_view]
  # This action is for to display all appraisal templates
  def index
    @appraisals = Appraisal.all
  end
  
  def new
    @appraisal = Appraisal.new
    @review_elements = ReviewElement.all
    @goals = Goal.all
  end
  
  def create
    @appraisal = Appraisal.create(appraisal_params)
    review_elements = params[:review_element_ids]
    # method call for adding reviews to appraisal template
    @appraisal.add_appraisal_reviews(review_elements) if review_elements.present?
    @appraisals = Appraisal.all
  end
  
  def edit
    @appraisal = Appraisal.find(params[:id])
    @review_elements = ReviewElement.all
    @appraisal_review_elements = @appraisal.appraisals_reviews
  end
  
  def update
    @appraisal = Appraisal.find(params[:id])
    @appraisal.update(appraisal_params)
    @appraisal.appraisals_reviews.destroy_all
    review_elements = params[:review_element_ids]
    # method call for adding reviews to appraisal template
    @appraisal.add_appraisal_reviews(review_elements) if review_elements.present?
    @appraisals = Appraisal.all
  end
  
  def assign_employee_appraisals
  end
  
  # action to display appraisal form for employees
  def assign_appraisal 
    @appraisals = Appraisal.all
  end
  
  # Here we will assign selected appraisal template to selected employee by reporting manager
  def create_appraisal
    employee_appraisal = EmployeesAppraisal.where(employee_id: params[:employee]).first
    if employee_appraisal.present?
      employee_appraisal.update(appraisal_id: params[:appraisal])
    else
      employee_appraisal = EmployeesAppraisal.create(employee_id: params[:employee], appraisal_id: params[:appraisal])
    end
    redirect_to assign_employee_appraisals_path
  end 
  
  # this will display appraisal form for employee
  def employee_appraisal_form
    @employee_appraisal = @employee.employees_appraisal_lists.where(status: Appraisal::EMPLOYEE).first
    appraisal = @employee_appraisal.appraisal if @employee_appraisal.present?
    @review_elements = appraisal.review_elements if appraisal.present?
    #@goals = @appraisal.goals if @appraisal.present?
  end
  
  # In this we will create employee appraisals details and reviews entered by employee
  def create_employee_appraisal
  # this method will create employee appraisal after he fills the appraisal form
    Appraisal.appraisal_creation(@employee, params[:review_id], params[:review_assesment],  params[:review_rating])  if params[:review_id].present?
    redirect_to my_appraisals_path
  end
  
  # to display reported employees apparaisal list
  def employee_appraisals
    # method will return employees and their appraisals arrays
    @appraisal_cycles = AppraisalCycle.all
    @employees, @appraisals = Appraisal.get_employees_appraisals(@employee) if @employee.is_reporting_manager?
  end
  
  # Manager view after employee submit his form
  def manager_view
    @employee = Employee.find(params[:id])
    # will get record with status with manager from EmployeesAppraisalList 
    @employee_appraisal = EmployeesAppraisalList.where(status: Appraisal::MANAGER, employee_id: @employee.id).first || EmployeesAppraisalList.where(status: Appraisal::HR, employee_id: @employee.id).first
    # appraisal from Appraisal table which was assigned and with status WITH MANAGER
    @appraisal = Appraisal.find(@employee_appraisal.appraisal_id)
    # Review elements of employee who fill above apprasal form
    @review_elements = @employee.employees_reviews.where(employee_id: @employee.id, appraisal_id: @appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id) if @employee.employees_reviews.present?
  end
  
  def manager_feedback
    @employee = Employee.find(params[:id])
    # method for create mangaer feed back and return appraisal record which was updated by manager
    employee_appraisal = Appraisal.manager_feedback_creation(@employee, params[:review_id], params[:manager_feedback], params[:manager_rating]) if params[:review_id].present?
    employee_appraisal.update(overall_rating: params[:over_all_rating], status: Appraisal::HR, discussion_notes: params[:discussion_notes])
    redirect_to appraisals_list_path
  end
  
  # this action is for appraisal view for hr 
  def hr_manager_view
  end
  
  def manager_appraisal_view
    @employee = Employee.find(params[:id])
    @employee_appraisal = EmployeesAppraisalList.where(employee_id: @employee.id, status: Appraisal::HR).first
    if @employee_appraisal.present? 
      @review_elements = EmployeesReview.where(employee_id: @employee.id, appraisal_id: @employee_appraisal.appraisal_id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
   end
  end
  
  def employee_appraisal_view
  end
  
  # this action in not in use but for future implementation  
  def indivisual_appraisals
    @employee_appraisals = EmployeesAppraisalList.where(employee_id: @employee.id)
    #@appraisals, @appraisal_cycles = Appraisal.find_employee_appraisals(employee_appraisals)
  end
  
  def reportees
    @employee = current_user.employee
    @reportees = ReportingManager.where(manager_id: @employee.id)
  end
  
  def reportee_appraisals
    @employee = Employee.find(params[:id])
    @employee_appraisals = EmployeesAppraisalList.where(employee_id: @employee.id, status: Appraisal::CLOSE)
  end
  
  def reportee_appraisal_view
  end
  
  private
  
  def appraisal_params
    params.require(:appraisal).permit(:title, :description)
  end
  
  def create_assign_list
     if current_user.employee.is_reporting_manager?
      @appraisals = Appraisal.all
      @employees = []
      employees = ReportingManager.where(manager_id: current_user.employee.id).map(&:employee_id)
      employees.each do |emp|
        @employees << Employee.find(emp)
      end
    end
  end
  
  def find_current_user
    @employee = current_user.employee
  end
  
  def appraisals_list
    @employee_appraisal = EmployeesAppraisalList.find(params[:id])
    @employee = Employee.find(@employee_appraisal.employee_id)
    if @employee_appraisal.present? 
      @review_elements = EmployeesReview.where(employee_id: @employee.id, appraisal_id: @employee_appraisal.appraisal_id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
   end
  end
  
end
