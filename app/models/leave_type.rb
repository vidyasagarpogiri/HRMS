class LeaveType < ActiveRecord::Base
 
  has_many :leave_histories
  validates :type_name, presence: true
   
end
