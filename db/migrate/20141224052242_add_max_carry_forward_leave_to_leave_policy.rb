class AddMaxCarryForwardLeaveToLeavePolicy < ActiveRecord::Migration
  def change
    add_column :leave_policies, :max_carry_forward_leaves, :float
  end
end
