FactoryGirl.define do 
	factory :employee do |f|
		f.first_name "sekhar"
		f.last_name "beri"
		f.employee_id "eTeki001"
		f.date_of_birth "22-08-1990"
		f.mobile_number 9866710310
		f.father_name "Adinarayana"
		f.blood_group_id "1"
		f.date_of_join "22-08-1990"
		f.alternate_email "sekhar.beri@gmail.com"
  	f.association :user, factory: :user
  	f.association :department, factory: :department
	end	

	factory :department do |f|
		f.department_name "HR"
	end
end 


