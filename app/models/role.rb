class Role < ActiveRecord::Base
  has_many :employees
 
  
  has_many :packages
  has_many :features, through: :packages
end
