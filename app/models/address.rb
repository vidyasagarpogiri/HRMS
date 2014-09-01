class Address < ActiveRecord::Base
  has_many :employees
  belongs_to :city
  has_one :job_location
  
# validations for fields
<<<<<<< HEAD
	
		
=======

	
>>>>>>> a0fd16ffb422331aecc43d7b29b52d21dc905269
end
