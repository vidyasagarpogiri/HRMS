class AppraisalCycle < ActiveRecord::Base
  belongs_to :department
  has_many :employees_appraisal_lists

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :period, presence: true
  validates :employee_dead_line, presence: true
  validates :manager_dead_line, presence: true
  validates :discussion_dead_line, presence: true
  validates :department_id, presence: true

  # constants for status of appraisal
  OPEN = 'Open'
  CLOSE = 'Close'

  after_create :assigning_appraisals

  # Author: sekhar
  # This method is to assign appraisals to employees of particular department for which appraisal cycle created
  def assigning_appraisals
    # department = cycle.department
    # to get all employees of department
    department_employees = department.employees
    # loop is for iterate every employee of department
    department_employees.each do |employee|
      # to get appraisal template which is assigned to employee
      appraisal = EmployeesAppraisal.find_by_employee_id(employee.id)
      if appraisal.present?
        # will assign appraisal with the template assign to employee
        apraisal_template = Appraisal.find(appraisal.appraisal_id)
        EmployeesAppraisalList.create(employee_id: employee.id, appraisal_id: appraisal.appraisal_id, is_assign: true, status: Appraisal::EMPLOYEE, appraisal_cycle_id: id, title: apraisal_template.title, description: apraisal_template.description, start_date: start_date, end_date: end_date, review_period: period)
      else
        # will assign appraisal with default template of that department
        EmployeesAppraisal.create(employee_id: employee.id, appraisal_id: department.appraisal_id)
        if department.appraisal_id.present?
          apraisal_template = Appraisal.find(department.appraisal_id) 
          EmployeesAppraisalList.create(employee_id: employee.id, appraisal_id: department.appraisal_id, is_assign: true, status: Appraisal::EMPLOYEE, appraisal_cycle_id: id, title: apraisal_template.title, description: apraisal_template.description, start_date: start_date, end_date: end_date, review_period: period)
        end
      end
    end
  end
end

