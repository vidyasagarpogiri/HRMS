class Employee < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
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

  belongs_to :group
  
  has_many :reporting_managers
  has_many :depatrments, :through => :reporting_managers
 	
 	
 	has_many :leave_history
 	
 	has_many :leave_types
 	
 	belongs_to :leave

	#validations for fields



	#validates :first_name, presence: true
	#validates :last_name, presence: true
	#validates :date_of_birth, presence: true
	#validates :gender, presence: true
  #validates :department_id, presence: true
	#validates :designation_id, presence: true
	#validates :mobile_number, presence: true
	#validates :father_name, presence: true
	#validates :blood_group_id, presence: true
	#validates :grade_id, presence: true
	#validates :email, presence: true
	#validates :date_of_confirmation, presence: true
	#validates :date_of_join, presence: true





end
