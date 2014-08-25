class Designation < ActiveRecord::Base
  has_many :employees
  has_many :promotions
end
