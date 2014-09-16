class Salary < ActiveRecord::Base
  has_one :employee
  has_many :allowances
  has_many :insentives
  has_many :salary_increments
   
  #validates :ctc_fixed, presence: true
	#validates :basic_salary, presence: true
  
end
