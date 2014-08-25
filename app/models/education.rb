class Education < ActiveRecord::Base
  has_many :employees
  belongs_to :city
  has_many :qualifications, through: :education_qualifications
  
end
