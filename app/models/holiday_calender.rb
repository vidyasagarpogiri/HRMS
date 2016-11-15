class HolidayCalender < ActiveRecord::Base
  
  belongs_to :department
  belongs_to :group
  belongs_to :event
  validates :event_id, :uniqueness => {:scope => :department_id} 
  
end
