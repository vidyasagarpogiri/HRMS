class CreateEmployeesGoals < ActiveRecord::Migration
  def change
    create_table :employees_goals do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :employee_id
      t.integer :employees_appraisal_list_id
      t.integer :appraisal_cycle_id
      t.timestamps
    end
  end
end
