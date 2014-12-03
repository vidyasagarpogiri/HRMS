FactoryGirl.define do 
	factory :investment_declaration do |f| 
		f.yearly_value 50000
		f.assesment_year 2014
		f.association :general_investment, factory: :general_investment
	end 
	
	
 
end 

