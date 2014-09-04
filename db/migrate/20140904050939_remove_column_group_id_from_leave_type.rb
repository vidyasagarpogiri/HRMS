class RemoveColumnGroupIdFromLeaveType < ActiveRecord::Migration
  def change
    remove_column :leave_types, :group_id
  end
end
