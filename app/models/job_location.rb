class JobLocation < ActiveRecord::Base
  has_many :employees
  belongs_to :address
  validates_numericality_of :zipcode, :maximum => 6, :minimum => 5, presence: true,  message: "Plese Enter only allows letters" 
end
