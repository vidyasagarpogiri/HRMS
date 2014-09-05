class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  has_many :holiday_calenders
  has_one :reporting_manager
  
  
end
