class AddDeductibleArrearsToPayslip < ActiveRecord::Migration
  def change
    add_column :payslips, :deductible_arrears, :float
  end
end
