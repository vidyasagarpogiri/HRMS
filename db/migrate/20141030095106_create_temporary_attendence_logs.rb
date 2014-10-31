class CreateTemporaryAttendenceLogs < ActiveRecord::Migration
  def change
    create_table :temporary_attendence_logs do |t|
      t.integer :device_id
      t.integer :employee_id
      t.timestamp :date_time
      t.timestamps
    end
  end
end
