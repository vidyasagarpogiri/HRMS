# Author: sekhar
class AppraisalsController < ApplicationController
  # to use application helper module methods
  include ApplicationHelper
  
  # filter for authentication
  before_filter :hr_view, only: [:index, :new, :edit, :hr_manager_view]
  before_filter :reporting_manager_view, only: [:new, :edit, :assign_appraisal, :assign_employee_appraisals, :manager_view, :employee_appraisals, :manager_view, :manager_feedback, :manager_appraisal_view, :reportees, :reportee_appraisals, :reportee_appraisal_view, :reportee_appraisal_edit, :reportee_appraisal_update ]
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
  # author: sekhar
  # This action is to display employees and their appraisal templates to their reporting manager
  def assign_employee_appraisals
  end
  # author: sekhar
  # action to display appraisal form for employees
  def assign_appraisal 
    @appraisals = Appraisal.all
  end
  
  # author: sekhar
  # Here we will assign selected appraisal template to selected employee by reporting manager
  def create_appraisal
  raise params.inspect
    employee_appraisal = EmployeesAppraisal.where(employee_id: params[:employee]).first
    if employee_appraisal.present?
      employee_appraisal.update(appraisal_id: params[:appraisal])
    else
      employee_appraisal = EmployeesAppraisal.create(employee_id: params[:employee], appraisal_id: params[:appraisal])
    end
    redirect_to assign_employee_appraisals_path
  end 
  
  # author: sekhar
  # this will display appraisal form for employee to fill
  def employee_appraisal_form
    @employee_appraisal = @employee.employees_appraisal_lists.where(status: Appraisal::EMPLOYEE).first
    appraisal = @employee_appraisal.appraisal if @employee_appraisal.present?
    @review_elements = appraisal.review_elements if appraisal.present?
    #@goals = @appraisal.goals if @appraisal.present?
  end
  # author: sekhar
  # In this we will create employee appraisals details and reviews entered by employee
  def create_employee_appraisal
  # this method will create employee appraisal after he fills the appraisal form
    Appraisal.appraisal_creation(@employee, params[:review_id], params[:review_assesment],  params[:review_rating])  if params[:review_id].present?
    redirect_to my_appraisals_path
  end
  
  # author: sekhar
  # to display reported employees apparaisal list to hr manager
  def employee_appraisals
    # method will return employees and their appraisals arrays
    @appraisal_cycles = AppraisalCycle.all
    @employees, @appraisals = Appraisal.get_employees_appraisals(@employee) if @employee.is_reporting_manager?
  end
  
  # author: sekhar
  # Manager view after employee submit his form
  def manager_view
    @employee = Employee.find(params[:id])
    # will get record with status with manager from EmployeesAppraisalList 
    @employee_appraisal = EmployeesAppraisalList.where(status: Appraisal::MANAGER, employee_id: @employee.id).first || EmployeesAppraisalList.where(status: Appraisal::HR, employee_id: @employee.id).first
    # appraisal from Appraisal table which was assigned and with status WITH MANAGER
    @appraisal = Appraisal.find(@employee_appraisal.appraisal_id)
    # Review elements of employee who fill above apprasal form
    @review_elements = @employee.employees_reviews.where(employee_id: @employee.id, appraisal_id: @appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id) if @employee.employees_reviews.present?
    @goals = @employee.employees_goals.where(employees_appraisal_list_id: @employee_appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id) 
  end
  
  #author: sekhar
  # Manager feed back of a particular appraisal will save here
  def manager_feedback
    @employee = Employee.find(params[:id])
    # method for create mangaer feed back and return appraisal record which was updated by manager
    employee_appraisal = Appraisal.manager_feedback_creation(@employee, params[:review_id], params[:manager_feedback], params[:manager_rating]) if params[:review_id].present?
    employee_appraisal.update(overall_rating: params[:over_all_rating], status: Appraisal::HR, discussion_notes: params[:discussion_notes])
    redirect_to appraisals_list_path
  end
  # author: sekhar
  # this action is for appraisal view for hr 
  def hr_manager_view
    @goals =EmployeesGoal.where(employee_id: @employee_appraisal.employee_id, employees_appraisal_list_id: @employee_appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
  end
  
  # author: sekhar
  # Manager view after submit appraisal form to HR
  def manager_appraisal_view
    @employee = Employee.find(params[:id])
    @employee_appraisal = EmployeesAppraisalList.where(employee_id: @employee.id, status: Appraisal::HR).first || EmployeesAppraisalList.where(status: Appraisal::REVIEW, employee_id: @employee.id).first
    @review_elements = EmployeesReview.where(employee_id: @employee.id, appraisal_id: @employee_appraisal.appraisal_id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
    @goals = @employee.employees_goals.where(employees_appraisal_list_id: @employee_appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)    
  end
  # aunthor: sekhar
  # this action is for employee appraisal
  def employee_appraisal_view
     @goals = @employee.employees_goals.where(employees_appraisal_list_id: @employee_appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
  end
  
  # author: sekhar
  # this is for previous appraisals view of an employee  
  def indivisual_appraisals
    @employee_appraisals = EmployeesAppraisalList.where(employee_id: @employee.id) 
    #@appraisals, @appraisal_cycles = Appraisal.find_employee_appraisals(employee_appraisals)
  end
  
  # author: sekhar
  # In this we will get all the employees of reporting manger
  def reportees
    @employee = current_user.employee
    @reportees = ReportingManager.where(manager_id: @employee.id)
  end
  
  # author: sekhar
  # view for reporting manger of his reportee`s prevoius appraisals
  def reportee_appraisals
    @employee = Employee.find(params[:id])
    @employee_appraisals = EmployeesAppraisalList.where(employee_id: @employee.id, status: Appraisal::CLOSE) 
  end
  
  # author: sekhar
  # reporting manager view for of his employee previous appraisal
  def reportee_appraisal_view
    @goals =EmployeesGoal.where(employee_id: @employee_appraisal.employee_id, employees_appraisal_list_id: @employee_appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
  end
  
  # author: sekhar
  # Appraisal form edit after status changed to review meeting
  def reportee_appraisal_edit
    @employee = Employee.find(params[:id])
    # will get record with status with manager from EmployeesAppraisalList 
    @employee_appraisal = EmployeesAppraisalList.where(status: Appraisal::REVIEW, employee_id: @employee.id).first
    # Review elements of employee who fill above apprasal form
    @review_elements = @employee.employees_reviews.where(employee_id: @employee.id, appraisal_id: @employee_appraisal.appraisal_id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id) if @employee.employees_reviews.present?
    @goal = EmployeesGoal.new    
  end
  
  # author: sekhar
  # Appraisal updation and goals creation of a particular employee appraisal
  def reportee_appraisal_update
    descriptions, start_date, end_date = params[:description], params[:start_date], params[:end_date]
    @employee = Employee.find(params[:id])
    @employee_appraisal = EmployeesAppraisalList.where(status: Appraisal::REVIEW, employee_id: @employee.id).first
    Appraisal.manager_feedback_creation(@employee, params[:review_id], params[:manager_feedback], params[:manager_rating]) if params[:review_id].present?
    if params[:title].present? 
      params[:title].each do |title|
        element_id = 0
        EmployeesGoal.create(title: title, description: descriptions[element_id], start_date: start_date[element_id], end_date: end_date[element_id], employee_id: @employee.id, employees_appraisal_list_id: @employee_appraisal.id, appraisal_cycle_id: @employee_appraisal.appraisal_cycle_id)
        element_id += 1
      end
    end
    @employee_appraisal.update(overall_rating: params[:over_all_rating], status: Appraisal::CLOSE, discussion_notes: params[:discussion_notes])
    redirect_to appraisals_list_path
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
