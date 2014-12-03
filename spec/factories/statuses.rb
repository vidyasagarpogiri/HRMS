FactoryGirl.define do
  factory :status do |s|
    s.status "MyText"
    s.employee_id 1
    s.likes_count 1
  end
  
end
