class AddColumnsToLeavePolicy < ActiveRecord::Migration
  def change
		add_column :leave_policies, :department_id, :integer
  end
end
