class AddStatusToPayslip < ActiveRecord::Migration
  def change
    add_column :payslips, :status, :string
  end
end
