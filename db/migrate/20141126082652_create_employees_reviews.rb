class CreateEmployeesReviews < ActiveRecord::Migration
  def change
    create_table :employees_reviews do |t|
      t.string :review_element
      t.string :performance_indicator
      t.string :employee_assesment
      t.string :employee_rating
      t.string :manager_feedback
      t.string :manager_rating
      t.integer :employee_id
      t.integer :appraisal_id
      t.integer :appraisal_cycle_id
      t.timestamps
    end
  end
end
