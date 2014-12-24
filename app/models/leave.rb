class Leave < ActiveRecord::Base
 belongs_to :employee
 
  
	validates :employee_id, presence: true
	
	
=begin	
	def self.employee_available_leaves(emp_id)
	  @employee = Employee.find(emp_id) 
    leave = @employee.leave || @employee.create_leave(pl_carry_forward_prev_year: 0, available_leaves: 0)
	  a_leaves = leave.available_leaves ||  0
	  cf_leaves = leave.pl_carry_forward_prev_year || 0
	  leave_policy = @employee.group.leave_policy
    if leave_policy.present?
      a_leaves += leave_policy.pl_this_year
      leave.update(available_leaves: a_leaves)
    end
	end
=end	



  def self.employee_available_leaves(emp_id)
    @employee = Employee.find(emp_id)
    leave = @employee.leave || @employee.create_leave(pl_carry_forward_prev_year: 0, available_leaves: 0)
    leaves = leave.available_leaves || 0
  end
=begin

  LeavePolicy(id: integer, pl_this_year: float, eligible_carry_forward_leaves: float, created_at: datetime, updated_at: datetime, department_id: integer, group_id: integer, max_carry_forward_leaves: float) 
=end
end
