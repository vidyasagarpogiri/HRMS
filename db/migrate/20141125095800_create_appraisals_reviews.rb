class CreateAppraisalsReviews < ActiveRecord::Migration
  def change
    create_table :appraisals_reviews do |t|
      t.integer :appraisal_id
      t.integer :review_element_id
      t.timestamps
    end
  end
end
