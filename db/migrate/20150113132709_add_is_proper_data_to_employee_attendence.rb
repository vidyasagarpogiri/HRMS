class AddIsProperDataToEmployeeAttendence < ActiveRecord::Migration
  def change
    add_column :employee_attendences, :is_proper_data, :boolean
  end
end
