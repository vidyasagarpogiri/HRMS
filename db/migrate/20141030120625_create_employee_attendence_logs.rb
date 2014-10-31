class CreateEmployeeAttendenceLogs < ActiveRecord::Migration
  def change
    create_table :employee_attendence_logs do |t|
      t.integer :employee_attendence_id
      t.datetime :time
      t.boolean :in_out

      t.timestamps
    end
  end
end
