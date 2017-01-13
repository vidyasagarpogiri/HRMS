class SalariesAllowance < ActiveRecord::Base
  
  # association
  belongs_to :salary
  belongs_to :allowance
  
end
