class Leave < ActiveRecord::Base
 belongs_to :employee
 
  
	validates :employee_id, presence: true
	
	
#=begin	
	def self.employee_available_leavesss(emp_id)
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
#=end	

#=begin
  def self.carry_forward_leaves(emp_id)
    @employee = Employee.find(emp_id) 
    leave = @employee.leave 
	  if leave.present?
	    cf_leaves = leave.pl_carry_forward_prev_year || 0
	    a_leaves = leave.available_leaves || 0
	    group = @employee.group
	    leave_policy = group.leave_policy if group.present?
      if group.present? && leave_policy.present?
        #a_leaves += leave_policy.pl_this_year
        leave_policy_cf_leaves = leave_policy.eligible_carry_forward_leaves || 0
        max_carry_forward_leaves = leave_policy.max_carry_forward_leaves || 0
        if leave_policy_cf_leaves >= a_leaves
          a_leaves
        else
          carry_leaves = [ cf_leaves +  leave_policy_cf_leaves, a_leaves].min
          final_cf_leaves = [max_carry_forward_leaves,  carry_leaves].min
        end
      else
        0
      end
	  else
	    0
	  end #Leave.present?
  end
#=end



  def self.employee_available_leaves(employee)
    leave = employee.leave || employee.create_leave(pl_carry_forward_prev_year: 0, available_leaves: 0)
    leaves = leave.available_leaves || 0
  end
=begin

  LeavePolicy(id: integer, pl_this_year: float, eligible_carry_forward_leaves: float, created_at: datetime, updated_at: datetime, department_id: integer, group_id: integer, max_carry_forward_leaves: float) 
  
  Leave(id: integer, pl_carry_forward_prev_year: float, pl_applied: float, sl_applied: float, created_at: datetime, updated_at: datetime, employee_id: integer, available_leaves: float) 


=end
end
