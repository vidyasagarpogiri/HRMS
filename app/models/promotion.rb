class Promotion < ActiveRecord::Base
  belongs_to :employee
  belongs_to :designation
  belongs_to :department
  belongs_to :grade
  
  validates :date_of_promotion, presence: true
	validates :designation_id, presence: true
end
