class Goal < ActiveRecord::Base
  has_many :appraisals, through: :appraisals_goals
  has_many :appraisals_goals
end
