class AddColumnsToPayslip < ActiveRecord::Migration
  def change
    add_column :payslips, :working_days, :float
    add_column :payslips, :basic_salary, :float
    add_column :payslips, :gross_salary, :float
    add_column :payslips, :arriars, :float
    add_column :payslips, :pf, :float
    add_column :payslips, :esic, :float
    add_column :payslips, :pt, :float
    add_column :payslips, :tds, :float
  end
end
