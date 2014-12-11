# This model is for comments of status # Author: Vidya Sagar Pogiri
class Comment < ActiveRecord::Base
  # comment belongs to status,posts,photos so polymorphic relation
  belongs_to :commentable, polymorphic: true
  belongs_to :employee # comments will be posted by employee
  default_scope { order('created_at DESC') }
  validates :comment, presence: true # validation for comment
  validates :employee_id, presence: true # validation for employee
  validates :commentable_id, presence: true # validation for commentable_id
  validates :commentable_type, presence: true # validation for commentable_type
end
