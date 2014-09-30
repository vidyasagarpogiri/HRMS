class LeavePolicy < ActiveRecord::Base
  belongs_to :group
  
  validates :pl_this_year, presence: true, numericality: true, length: { maximum: 4 } 
	validates :eligible_carry_forward_leaves, presence: true, numericality: true, length: { maximum: 4 }  
	belongs_to :department
end
