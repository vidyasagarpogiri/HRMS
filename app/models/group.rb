class Group < ActiveRecord::Base
  has_many :employees
  has_one :leave_policy
  has_one :holiday_calender
<<<<<<< HEAD
  has_one :reporting_manager
=======
  
>>>>>>> 6a4cfa7ca82e6c75ddee9cd1db3beed2b7fb8a3b
end
