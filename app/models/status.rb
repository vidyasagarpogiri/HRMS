# This model is for status of employee
class Status < ActiveRecord::Base
  belongs_to :employee  # status belongs to employee
  has_many :comments  # status may have more than 1 comment so has_many
  has_many :likes # one status may have more than one like
  validates :status, presence: true # validation for status
  validates :employee_id, presence: true # validation for employee
end
