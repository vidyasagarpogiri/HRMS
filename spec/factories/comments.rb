FactoryGirl.define do
  factory :comment do |c|
    c.comment "MyText"
    c.employee_id 1
    #c.association :status, factory: :status
    c.commentable_id 1
    c.commentable_type "status"
    #f.association :user, factory: :user
  end

end
