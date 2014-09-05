class Grade < ActiveRecord::Base
  has_many :employees
  
  validates :value, uniqueness: { case_sensitive: false }
end
