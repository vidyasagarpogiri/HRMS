class EducationQualification < ActiveRecord::Base
  belongs_to :education
  belongs_to :qualification
end   
