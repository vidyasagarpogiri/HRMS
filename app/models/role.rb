class Role < ActiveRecord::Base
  has_many :employees
  has_many :role_previliges
  
  validates :role_name, uniqueness: { case_sensitive: false }
end
