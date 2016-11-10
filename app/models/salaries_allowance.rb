class SalariesAllowance < ActiveRecord::Base
  belongs_to :salary
  belongs_to :allowance
end
