class AppraisalsGoal < ActiveRecord::Base
  belongs_to :appraisal
  belongs_to :goal
end
