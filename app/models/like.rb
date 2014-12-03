# This model is for status like # Author: Vidya Sagar Pogiri
class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :employee # like will be liked by employee
  belongs_to :status # status will have a like
  validates :employee_id, presence: true # validation for employee
  validates :is_like, inclusion:  { in:  [true, false] } # validation for like
  #validates :status_id, presence: true # validation for status
end
