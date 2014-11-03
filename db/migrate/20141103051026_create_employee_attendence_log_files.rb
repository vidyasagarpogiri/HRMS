class CreateEmployeeAttendenceLogFiles < ActiveRecord::Migration
  def change
    create_table :employee_attendence_log_files do |t|
      t.string :log_file

      t.timestamps
    end
  end
end
