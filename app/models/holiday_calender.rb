class HolidayCalender < ActiveRecord::Base
        
  #association
  belongs_to :department
  belongs_to :group              
  belongs_to :event    
                                                          
  #validation
  validates :event_id, :uniqueness => {:scope => :department_id} 
  
end
