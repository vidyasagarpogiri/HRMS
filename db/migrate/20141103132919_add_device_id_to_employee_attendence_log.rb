class AddDeviceIdToEmployeeAttendenceLog < ActiveRecord::Migration
  def change
    add_column :employee_attendence_logs, :devise_id, :string
  end
end
