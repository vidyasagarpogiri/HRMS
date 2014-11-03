class AddModeToPayslip < ActiveRecord::Migration
  def change
    add_column :payslips, :mode, :string
  end
end
