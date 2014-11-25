class CreateAppraisals < ActiveRecord::Migration
  def change
    create_table :appraisals do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :review_period
      t.string :over_all_rating
      t.integer :manager_id
      t.integer :employee_id
      t.integer :department_id
      t.timestamps
    end
  end
end
