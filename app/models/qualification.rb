class Qualification < ActiveRecord::Base
  
  has_many :educations, through: :education_qualifications
  has_many :education_qualifications
  
end
