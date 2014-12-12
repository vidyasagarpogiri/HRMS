class CreateEmployeesAppraisals < ActiveRecord::Migration
  def change
    create_table :employees_appraisals do |t|
      t.integer :employee_id
      t.integer :appraisal_id
      t.timestamps
    end
  end
end
