class CreateAppraisalsGoals < ActiveRecord::Migration
  def change
    create_table :appraisals_goals do |t|
      t.integer :appraisal_id
      t.integer :goal_id
      t.timestamps
    end
  end
end
