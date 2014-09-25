class RemoveColumnsFromLeavePolicy < ActiveRecord::Migration
  def change
    remove_column :leave_policies, :sl_this_year
    remove_column :leave_policies, :group_id
  end
end
