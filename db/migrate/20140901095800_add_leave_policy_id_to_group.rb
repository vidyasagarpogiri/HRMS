class AddLeavePolicyIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :leave_policies_id, :integer
  end
end
