class Designation < ActiveRecord::Base
  has_many :employees
  has_many :promotions
  belongs_to :departmnet
  
  validates :designation_name, uniqueness: { case_sensitive: false }
end
