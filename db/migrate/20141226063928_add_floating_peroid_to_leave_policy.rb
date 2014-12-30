class AddFloatingPeroidToLeavePolicy < ActiveRecord::Migration
  def change
    add_column :leave_policies, :floating_leave_period, :integer
  end
end
