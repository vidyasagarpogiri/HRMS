class ReviewElement < ActiveRecord::Base
    has_many :appraisals, through: :appraisals_reviews
    has_many :appraisals_reviews
end
