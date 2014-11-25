class CreateReviewElements < ActiveRecord::Migration
  def change
    create_table :review_elements do |t|
      t.string :review_element
      t.string :performance_indicator
      t.string :employee_assesment
      t.string :employee_rating
      t.string :manager_feedback
      t.string :manager_rating
      t.timestamps
    end
  end
end
