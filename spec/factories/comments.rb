FactoryGirl.define do
  factory :comment do |c|
    c.comment "MyText"
    c.employee_id 1
    c.association :status, factory: :status
    #f.association :user, factory: :user
  end

end
