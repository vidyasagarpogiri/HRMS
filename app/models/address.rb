class Address < ActiveRecord::Base
  has_many :employees
  has_one :job_location
  
# validations for fields

end
