class Employee < ActiveRecord::Base
  belongs_to :department
  belongs_to :blood_group
  belongs_to :designation
  belongs_to :job_location
  belongs_to :present_address, :class_name=>"Address", foreign_key: :id
  belongs_to :permanent_address, :class_name=>"Address", foreign_key: :id
  belongs_to :education
  belongs_to :ff_status
  belongs_to :role
  belongs_to :grade
  belongs_to :user
  belongs_to :salary
  has_many :promotions
  has_many :educations
  has_many :experiences
 	
end
