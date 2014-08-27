class Salary < ActiveRecord::Base
  has_one :employee
  has_many :allowances
  has_many :insentives
end
