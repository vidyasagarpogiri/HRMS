class CreatePayslips < ActiveRecord::Migration
  def change
    create_table :payslips do |t|
      t.string :month_and_year
      t.float :no_of_working_days
      t.float :total_deductions
      t.float :arrears
      t.float :netpay
      t.integer :employee_id
      t.timestamps
    end
  end
end
