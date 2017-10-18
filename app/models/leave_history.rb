class LeaveHistory < ActiveRecord::Base 

  belongs_to :employee
  belongs_to :leave_type
  before_create :status_hold
	
  HOLD = "HOLD"             
  APPROVED = "APPROVED"
  REJECTED = "REJECTED"
  STARTED = "STARTED"
  COMPLETE = "COMPLETE"

  #validates :from_date, presence: true
  #validates :to_date, presence: true
  #validates :leave_type_id, presence: true
  #validates :reason, presence: true
    
  private
  def status_hold
    self.status = HOLD
  end

end
