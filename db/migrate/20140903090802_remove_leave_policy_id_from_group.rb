class RemoveLeavePolicyIdFromGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :leave_policies_id
  end
end
