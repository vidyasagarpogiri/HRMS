class Role < ActiveRecord::Base
  has_many :employees
  has_many :role_previliges
end
