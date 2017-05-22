class LeavePolicy < ActiveRecord::Base
  
  belongs_to :group                                             
  belongs_to :department                                                
                                                                     
  validates :pl_this_year, presence: true 
  validates :eligible_carry_forward_leaves, presence: true
  
end
