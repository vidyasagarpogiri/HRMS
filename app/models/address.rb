class Address < ActiveRecord::Base

 # Associations
  belongs_to :employee 
  has_one :job_location
	
  # validations	           
  validates :line1, presence: true
  validates :line, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zipcode, presence: true	
	
end
