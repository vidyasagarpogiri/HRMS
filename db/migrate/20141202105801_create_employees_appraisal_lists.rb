class CreateEmployeesAppraisalLists < ActiveRecord::Migration
  def change
    create_table :employees_appraisal_lists do |t|
      t.integer :employee_id
      t.integer :appraisal_id
      t.boolean :is_assign, :default => false
      t.string :status
      t.string :overall_rating
      t.integer :appraisal_cycle_id
      t.timestamps
    end
  end
end
