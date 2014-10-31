class AddEmployeeToPayRollMaster < ActiveRecord::Migration
  def change
     add_column :pay_roll_masters, :employee_id, :integer
  end
end
