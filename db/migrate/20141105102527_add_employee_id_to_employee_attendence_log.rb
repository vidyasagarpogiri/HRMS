class AddEmployeeIdToEmployeeAttendenceLog < ActiveRecord::Migration
  def change
    add_column :employee_attendence_logs, :employee_id, :integer
  end
end
