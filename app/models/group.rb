class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  has_many :holiday_calenders
  has_many :events, :through => :holiday_calenders
  

end
