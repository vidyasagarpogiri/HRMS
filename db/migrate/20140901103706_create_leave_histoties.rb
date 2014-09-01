class CreateLeaveHistoties < ActiveRecord::Migration
  def change
    create_table :leave_histoties do |t|
      t.string :from_date
      t.string :to_date
      t.float :days
      t.text :reason
      t.string :feedback
      t.integer :leave_type_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
