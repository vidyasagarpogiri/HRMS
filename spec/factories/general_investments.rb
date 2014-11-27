FactoryGirl.define do 
	factory :general_investment do |f| 
		f.title "HRA"
		f.description "Hello You Need Submit"
		f.association :section_declaration, factory: :section_declaration
	end 
	
	
 
end 

