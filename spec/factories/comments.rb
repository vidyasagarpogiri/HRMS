FactoryGirl.define do
  factory :comment do |c|
    c.comment "MyText"
    c.employee_id 1
    #c.association :status, factory: :status
    c.commentable_id 1
    c.commentable_type "status"
    #f.association :user, factory: :user
  end
  
  factory :comment do |album_comment|
    album_comment.comment "MyText"
    album_comment.employee_id 1
    #album_comment.association :albums, factory: :album
    album_comment.commentable_id 1
    album_comment.commentable_type "album"
    #album_comment.association :user, factory: :user
  end

end
