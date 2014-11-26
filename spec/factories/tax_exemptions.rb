FactoryGirl.define do
  factory :tax_exemption do
    gender "Male"
    exemption_limit 100000
  end
  
  factory :invalid_tax_exemption, parent: :tax_exemption do
    gender "Male"
    exemption_limit nil
  end

end
