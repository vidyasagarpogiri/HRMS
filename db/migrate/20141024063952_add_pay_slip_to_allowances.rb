class AddPaySlipToAllowances < ActiveRecord::Migration
  def change
    add_column :allowances, :payslip_id, :integer
    add_column :allowances, :total_value, :float
  end
  
end
