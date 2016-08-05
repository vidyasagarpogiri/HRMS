class Designation < ActiveRecord::Base
  has_many :employees
  has_many :promotions
  has_many :grades
  belongs_to :departmnet
  validates :designation_name, presence: true, uniqueness: { case_sensitive: false }
end
