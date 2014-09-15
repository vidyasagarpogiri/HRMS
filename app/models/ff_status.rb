class FfStatus < ActiveRecord::Base
  has_many :employees
	
	
	OPEN = "OPEN"
	HOLD = "HOLD"
	CLOSE = "CLOSE"
	STATUS = [OPEN, HOLD, CLOSE]
end
