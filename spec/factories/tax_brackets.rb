FactoryGirl.define do
  factory :tax_bracket do
    bracket "3rd Bracket"
    lower_limit 500000
    upper_limit 1000000
    tax_percentage 20
    min_tax 25000
  end
  
  factory :invalid_tax_bracket, parent: :tax_bracket do
    bracket "Bracket"
    lower_limit nil
    upper_limit nil
    tax_percentage nil
    min_tax nil
  end
  
  factory :custom_tax_bracket, parent: :tax_bracket do
    bracket "3rd Bracket"
    lower_limit 1500000
    upper_limit 1000000
    tax_percentage 20
    min_tax 25000
  end

end
