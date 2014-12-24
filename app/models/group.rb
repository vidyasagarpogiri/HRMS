class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  
  has_many :holiday_calenders,  dependent: :destroy
  has_many :events, :through => :holiday_calenders
  
  has_many :amzur_events, as: :eventable
  has_many :announcements, as: :announceable
  

end
