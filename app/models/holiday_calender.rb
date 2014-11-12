class HolidayCalender < ActiveRecord::Base
  belongs_to :group
  belongs_to :event
  
  validates :event_id, :uniqueness => {:scope => :group_id}
  
end
