class CreateLeavePolicies < ActiveRecord::Migration
  def change
    create_table :leave_policies do |t|
      t.float :pl_per_year
      t.float :sl_per_year
      t.float :eligible_carry_forward_leaves

      t.timestamps
    end
  end
end
