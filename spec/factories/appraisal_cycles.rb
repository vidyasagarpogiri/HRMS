FactoryGirl.define do
  factory :appraisal_cycle do
    title "Appraisal1"
    start_date "24/11/2014"
    end_date "29/11/2014"
    period "Qpr1"
    employee_dead_line "25/11/2014"
    manager_dead_line "26/11/2014"
    discussion_dead_line "28/11/2014"
    status "open"
    department_id 1
    
    after(:build) { |appraisal_cycle| appraisal_cycle.class.skip_callback(:create, :after, :assigning_appraisals) }
  end
end

