class CreateAppraisalCycles < ActiveRecord::Migration
  def change
    create_table :appraisal_cycles do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :period
      t.date :employee_dead_line
      t.date :manager_dead_line
      t.date :discussion_dead_line
      t.string :status
      t.integer :department_id
      t.timestamps
    end
  end
end
