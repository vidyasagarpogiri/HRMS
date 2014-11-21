class AddGroupToLeavePolicy < ActiveRecord::Migration
  def change
    add_column :leave_policies, :group_id, :integer
  end
end
