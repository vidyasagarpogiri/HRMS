# This model is for status of employee # Author: Vidya Sagar Pogiri
class Status < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :employee  # status belongs to employee
  #has_many :comments, dependent: :destroy  # status may have more than 1 comment so has_many
  #has_many :likes, dependent: :destroy # one status may have more than one like
  validates :status, presence: true # validation for status
  validates :employee_id, presence: true # validation for employee
  default_scope { order('updated_at DESC') }
end
