class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  has_one :holiday_calender
  
end
