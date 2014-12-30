class LeavePolicy < ActiveRecord::Base
  belongs_to :group
  
  validates :pl_this_year, presence: true, numericality: true, length: { maximum: 4 } 
	validates :eligible_carry_forward_leaves, presence: true, numericality: true, length: { maximum: 4 }  
	belongs_to :department
	
	def show_floating_leave_type(floating)
	  case floating
	  when 1
	    'Quartely'
	  when 2
	    'Half Yearly'
	  else
	    'Annually'
	 end
	end
end
