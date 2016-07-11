class Grade < ActiveRecord::Base
  has_many :employees
  belongs_to :designation
  # validates :value, uniqueness: { case_sensitive: false }
end
