class FfStatus < ActiveRecord::Base
	
  has_many :employees

 OPEN = "OPEN"
 HOLD = "HOLD"
 CLOSE = "CLOSE"
 STATUS = [OPEN, HOLD, CLOSE]
	
validates :status_name, presence: true
validates :date_of_exit, presence: true
validates :interview_status, presence: true
validates :summary, presence: true
	
end
