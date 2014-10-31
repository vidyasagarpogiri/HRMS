class CreateEmployeeAttendences < ActiveRecord::Migration
  def change
    create_table :employee_attendences do |t|
      t.integer :employee_id
      t.date :log_date
      t.boolean :is_present
      t.float :total_working_hours 
      t.timestamps
    end
  end
end
