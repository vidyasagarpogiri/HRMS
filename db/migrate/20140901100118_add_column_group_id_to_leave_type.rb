class AddColumnGroupIdToLeaveType < ActiveRecord::Migration
  def change
    add_column :leave_types, :group_id, :integer
  end
end
