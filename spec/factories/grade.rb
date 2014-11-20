FactoryGirl.define do 
	factory :grade do |f| 
		f.value "balaraju"
	end 

	factory :invalid_grade, parent: :grade do |f| 
    	f.value nil 
  	end 
end 
