FactoryGirl.define do
  factory :appraisal do
    sequence(:title) { |i| "Review_#{i}" }
    description "this form will indicate your performance on different tasks"
  end
end
