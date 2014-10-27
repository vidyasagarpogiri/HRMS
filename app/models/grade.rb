class Grade < ActiveRecord::Base
  has_many :employees
  belongs_to :designation
  has_many :promotions
  #validates :value, uniqueness: { case_sensitive: false }
end
