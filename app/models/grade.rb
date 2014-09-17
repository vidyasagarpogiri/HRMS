class Grade < ActiveRecord::Base
  has_many :employees
  belongs_to :department
  validates :value, uniqueness: { case_sensitive: false }
end
