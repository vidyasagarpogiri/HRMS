# This model is for comments of status # Author: Vidya Sagar Pogiri
class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  #belongs_to :status # Comments belongs to status
  belongs_to :employee # comments will be posted by employee
  default_scope { order('created_at DESC') }
  validates :comment, presence: true # validation for comment
  validates :employee_id, presence: true # validation for employee
  #validates :status_id, presence: true # validation for status
  # scope :recent, order('created_at desc').limit(10)
  # Comment.order("updated_at desc").limit(10)
end
