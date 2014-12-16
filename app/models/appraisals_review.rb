class AppraisalsReview < ActiveRecord::Base
  belongs_to :appraisal
  belongs_to :review_element
end
