class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  has_many :leave_types
  has_one :holiday_calender
end
