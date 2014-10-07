class Salary < ActiveRecord::Base
  has_one :employee
  has_many :insentives
  has_many :salary_increments


  has_many :allowances
 
end
