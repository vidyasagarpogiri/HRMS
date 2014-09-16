class HolidayCalender < ActiveRecord::Base
  belongs_to :department
  belongs_to :group
  belongs_to :event
  
end
