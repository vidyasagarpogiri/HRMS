class Department < ActiveRecord::Base
  has_many :employees
  has_many :reporting_managers
  has_many :employees, :through => :reporting_managers
  
  validates :department_name, uniqueness: { case_sensitive: false }
end
