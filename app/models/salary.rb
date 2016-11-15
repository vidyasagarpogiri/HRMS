class Salary < ActiveRecord::Base
  
  has_one :employee
  has_many :insentives
  has_many :salary_increments
   
  #validates :ctc_fixed, presence: true
  #validates :basic_salary, presence: true
  
  has_many :salaries_allowances
  has_many :allowances, :through => :salaries_allowances

  def basic
    basic_salary = (self.gross_salary * 40)/100
  end
  def pf
    (self.basic * 10)/100
  end
  
  def esic
    (self.basic * 10)/100
  end
  
  def pf_contribution
    (self.pf * 50)/100
  end
  
  def esic_contribution
    (self.esic * 50)/100
  end
  #def ctc_sum
   # self.ctc_fixed = 
 # end
end
