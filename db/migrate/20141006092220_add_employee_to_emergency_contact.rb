class AddEmployeeToEmergencyContact < ActiveRecord::Migration
  def change
    add_column :emergency_contacts, :employee_id, :integer
  end
end
