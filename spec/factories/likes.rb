FactoryGirl.define do
  factory :like do |l|
    l.is_like false
    l.employee_id 1
    l.association :status, factory: :status
  end

end
