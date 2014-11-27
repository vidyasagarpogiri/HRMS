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

  factory :low_tax_bracket, parent: :tax_bracket do
    bracket "low_tax_bracket"
    lower_limit 0
    upper_limit 250000
    tax_percentage 0
    min_tax 0
  end
  
  factory :medium_tax_bracket, parent: :tax_bracket do
    bracket "medium_tax_bracket"
    lower_limit 250001
    upper_limit 500000
    tax_percentage 10
    min_tax 0
  end
  
  factory :high_tax_bracket, parent: :tax_bracket do
    bracket "high_tax_bracket"
    lower_limit 500001
    upper_limit 1000000
    tax_percentage 20
    min_tax 250000
  end
  
  factory :very_high_tax_bracket, parent: :tax_bracket do
    bracket "very_high_tax_bracket"
    lower_limit 1000001
    upper_limit 10000000
    tax_percentage 30
    min_tax 1250000
  end
  
end
