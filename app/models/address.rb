class Address < ActiveRecord::Base
  belongs_to :employee
  has_one :job_location
  
# validations for fields

  validates :line1, presence: true
	validates :line, presence: true
	validates :city, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :state, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
  validates :country, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :zipcode, presence: true, numericality: true , length: { maximum: 6 , minimum: 6 }	
	
end
