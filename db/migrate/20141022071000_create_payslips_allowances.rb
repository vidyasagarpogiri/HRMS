class CreatePayslipsAllowances < ActiveRecord::Migration
  def change
    create_table :payslips_allowances do |t|
      t.integer :allowance_id
      t.integer :payslip_id
      t.boolean :is_deductable, :default => false
      t.timestamps
    end
  end
end
