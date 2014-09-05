class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  has_one :holiday_calender
  has_one :reporting_manager
end
