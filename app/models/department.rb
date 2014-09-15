class Department < ActiveRecord::Base
  has_many :employees
  has_many :reporting_managers
  has_many :designations
  #TODO since there is a problem in relation with employ and department i have commented this - vidyasagar
  #has_many :employees, :through => :reporting_managers
  
  validates :department_name, uniqueness: { case_sensitive: false }, presence: true
end
