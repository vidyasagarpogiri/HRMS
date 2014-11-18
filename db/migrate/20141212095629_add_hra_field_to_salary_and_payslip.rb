class AddHraFieldToSalaryAndPayslip < ActiveRecord::Migration
  def change
    add_column :salaries, :hra, :float
    add_column :payslips, :hra, :float
  end
end
