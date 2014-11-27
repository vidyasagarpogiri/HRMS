FactoryGirl.define do 
	factory :investment_declaration do |f| 
	  f.association :general_investment, factory: :general_investment
		f.yearly_value 50000
		#f.employee_id Employee.last
	end 
	
	
 
end 

