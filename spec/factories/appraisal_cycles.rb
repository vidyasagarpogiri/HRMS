FactoryGirl.define do
  factory :appraisal_cycle do |f|
    f.title "Appraisal1"
    f.start_date "24/11/2014"
    f.end_date "29/11/2014"
    f.period 3
    f.employee_dead_line "25/11/2014"
    f.manager_dead_line "26/11/2014"
    f.discussion_dead_line "28/11/2014"
    f.status "open"
    f.department_id 1
  end
end

