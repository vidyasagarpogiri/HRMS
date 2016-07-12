class Address < ActiveRecord::Base
  belongs_to :employee # belongs to relation
  has_one :job_location # has one realtion
  
  validates :line1, presence: true
  validates :line, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zipcode, presence: true	
	
end
