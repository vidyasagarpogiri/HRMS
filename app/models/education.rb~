class Education < ActiveRecord::Base
  belongs_to :employee
  belongs_to :city
  has_many :qualifications, through: :education_qualifications
  has_many :education_qualifications
  
end
