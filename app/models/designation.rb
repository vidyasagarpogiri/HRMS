class Designation < ActiveRecord::Base
  has_many :employees
  has_many :promotions
  has_many :grades
  has_many :roles
  belongs_to :department
  
  validates :designation_name, presence: true
  
  HRADMIN = "HR ADMIN"
end
