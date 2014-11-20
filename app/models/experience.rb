class Experience < ActiveRecord::Base
  belongs_to :employee

  
  validates :previous_company, presence: true, format: { with: /\A[a-zA-Z0-9\s ]+\z/, message: "Plese Enter only letters" }
	validates :last_designation, presence: true, format: { with: /\A[a-zA-Z\.\s ]+\z/, message: "Plese Enter only letters" }
	validates :from_date, presence: true
	validates :to_date, presence: true
  
  
end
