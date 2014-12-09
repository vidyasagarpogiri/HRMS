class Department < ActiveRecord::Base
  has_many :employees
  has_many :reporting_managers
  has_many :designations
  has_many :promotions
  has_many :grades
  has_many :roles
  has_many :appraisal_cycles
  has_many :appraisals
  
  
  has_many :amzur_events, as: :eventable
  #TODO since there is a problem in relation with employ and department i have commented this - vidyasagar
  #has_many :employees, :through => :reporting_managers
  
  validates :department_name, uniqueness: { case_sensitive: false }, presence: true



	HR = "HR"
	ACCOUNTS = "Accounts"
end
