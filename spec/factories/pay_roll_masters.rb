 FactoryGirl.define do
  factory :pay_roll_master do |p|
    p.assesment_year Date.today.year
    p.employee_id Employee.last
    p.total_income 0
    p.total_savings 0
    p.total_tds 0
    p.status "open"
  end
end
