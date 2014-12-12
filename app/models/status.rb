# This model is for status of employee # Author: Vidya Sagar Pogiri
class Status < ActiveRecord::Base
  # status  have more than one comment
  has_many :comments, as: :commentable, dependent: :destroy
  # status have more than one like
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :employee  # status belongs to employee
  validates :status, presence: true # validation for status
  validates :employee_id, presence: true # validation for employee
  # Displays the status in descending order based on last updated time
  default_scope { order('updated_at DESC') }
end
