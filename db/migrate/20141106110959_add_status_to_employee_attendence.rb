class AddStatusToEmployeeAttendence < ActiveRecord::Migration
  def change
    add_column :employee_attendences, :status, :string
  end
end
