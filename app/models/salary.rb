class Salary < ActiveRecord::Base
  has_one :employee
  has_many :insentives
  has_many :salary_increments
   
  #validates :ctc_fixed, presence: true
	#validates :basic_salary, presence: true

  has_many :allowances
  #def ctc_sum
   # self.ctc_fixed = 
 # end
end
