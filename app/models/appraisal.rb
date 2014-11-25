class Appraisal < ActiveRecord::Base
  belongs_to :department
  belongs_to :employee
end
