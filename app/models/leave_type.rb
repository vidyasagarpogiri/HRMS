class LeaveType < ActiveRecord::Base
    belongs_to :leave_history
    
    validates :type_name, presence: true
    
end
