class Education < ActiveRecord::Base
  belongs_to :employee
  belongs_to :city
  has_many :qualifications, through: :education_qualifications
  has_many :education_qualifications
  
  
  validates :specilization, presence: true, format: { with: /\A[a-zA-Z\.\-\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :institute, presence: true, format: { with: /\A[a-zA-Z0-9\.\-\,\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :year_of_pass, presence: true, length: { is: 4 }, numericality: { only_integer: true }
  validates :cgpa_percentage, presence: true, numericality: { only_integer: false, less_than: 100 }
	

end
