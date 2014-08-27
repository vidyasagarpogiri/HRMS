class Salary < ActiveRecord::Base
  has_one :employee
  has_many :allowances
  has_many :insentives
  has_many :salary_increments
end
