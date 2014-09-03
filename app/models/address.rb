class Address < ActiveRecord::Base
  has_many :employees
  has_one :job_location
  
# validations for fields

  validates :line1, presence: true
	validates :line, presence: true
	validates :city, presence: true
	validates :state, presence: true
  validates :country, presence: true
	validates :zipcode, presence: true
	
end
