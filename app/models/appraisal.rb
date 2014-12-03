class Appraisal < ActiveRecord::Base
  belongs_to :department
  belongs_to :employee
  has_many :goals, through: :appraisals_goals
  has_many :appraisals_goals
  has_many :review_elements, through: :appraisals_reviews
  has_many :appraisals_reviews
  has_many :employees, through: :employees_appraisals
  has_many :employees_appraisals
  has_many :employees_appraisal_lists
  belongs_to :department
  
  #constants for status
  EMPLOYEE = "With Employee"
  MANAGER = "With Manager"
  HR = "With HR"
  CLOSE = "close"
  
  #author : sekhar 
  # this will retrun appraisals array for which their status is close
  def self.find_employee_appraisals(employee_appraisals)
    appraisals = []
    appraisal_cycles = []
    employee_appraisals.each do |appr|
      appraisal_cycle = AppraisalCycle.find(appr.appraisal_cycle_id)
      appraisal = Appraisal.find(appr.appraisal_id)
      appraisals << appraisal
      appraisal_cycles << appraisal_cycle
    end
    return appraisals,appraisal_cycles
  end
    #author : sekhar 
  # this method is to add reviews to employees
  def add_appraisal_reviews(review_elements)
    review_elements.each do |review_id|
        AppraisalsReview.create(appraisal_id: id, review_element_id: review_id.to_i)
      end
  end
  
  #author : sekhar 
  # this will retrun appraisals and employees arrays
    def self.get_employees_appraisals(employee)
    employees = []
    appraisals = []
    reported_employees_ids = ReportingManager.where(manager_id: employee.id).map(&:employee_id)
    reported_employees_ids.each do |emp| 
      employee = Employee.find(emp)
      employee_appraisal = EmployeesAppraisalList.where(status: Appraisal::MANAGER, employee_id: employee.id).first
      appraisal = Appraisal.find(employee_appraisal.appraisal_id) if employee_appraisal.present? 
      employees << employee # push each employee into employees array
      appraisals << appraisal if appraisal.present? # to push each appraisal into appraisals array
    end
    return employees, appraisals
  end
  
  # Author: sekhar
  # for appraisal creation of an employee
  # review_ids are ids of review elements of that appraisal
  # review_assesments and review_ratings are arrays which are passed as parameters of review ratings and assesments filled ny employee in the from
  
  def self.appraisal_creation(employee, review_ids, review_assesments, review_ratings)
    i=0
    employee_appraisal = employee.employees_appraisal_lists.where(status: Appraisal::EMPLOYEE).first
    review_ids.each do |id|
      review = ReviewElement.find(id.to_i)
      # here we create employee reviews of a particular employee appraisal
      EmployeesReview.create(review_element: review.review_element, performance_indicator: review.performance_indicator, employee_assesment: review_assesments[i], employee_rating: review_ratings[i], employee_id: employee.id, appraisal_id: employee_appraisal.appraisal_id, appraisal_cycle_id: employee_appraisal.appraisal_cycle_id)
      i += 1
    end
    employee_appraisal.update(status: Appraisal::MANAGER)
  end
 # for creation of manager feed_back 
  def self.manager_feedback_creation(employee, review_ids, manager_assesments, manager_ratings)
    i=0
     review_ids.each do |id|
      employee_review = EmployeesReview.find(id.to_i)
      employee_review.update(manager_feedback: manager_assesments[i], manager_rating: manager_ratings[i])
     end
    employee_appraisal = EmployeesAppraisalList.where(status: Appraisal::MANAGER, employee_id: employee.id).first
  end
end
