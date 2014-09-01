class Address < ActiveRecord::Base
  has_many :employees
  belongs_to :city
  has_one :job_location
  
# validations for fields
	
	validates :line, presence: true
	validates :line1, presence: true
	
end
