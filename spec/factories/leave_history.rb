FactoryGirl.define do
  factory :leave_history do
    from_date "30/01/2015"
    to_date "30/01/2015"
    reason "MyString"
    leave_type_id 1
    employee_id 1
  end

end

