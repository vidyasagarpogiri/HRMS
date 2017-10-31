class Education < ActiveRecord::Base
  
  belongs_to :employee
  belongs_to :city	
  has_many :qualifications, through: :education_qualifications
  has_many :education_qualifications
  
  validates :specilization, presence: true               
  validates :institute, presence: true
  validates :year_of_pass, presence: true
  validates :cgpa_percentage, presence: true	
end
        
               
