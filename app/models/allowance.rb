class Allowance < ActiveRecord::Base
  
  has_many :salaries_allowances                                                                                                                             
  has_many :salaries, :through => :salaries_allowances
  
end 
