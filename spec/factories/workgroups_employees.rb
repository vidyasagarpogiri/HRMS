FactoryGirl.define do
  factory :workgroups_employee do |w|
    w.employee_id 1
    w.workgroup_id 1
    w.is_moderator false
    w.association :workgroup, factory: :workgroup
  end

end
