class Employee < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
  belongs_to :department
  belongs_to :blood_group
  belongs_to :designation
  belongs_to :job_location
 # belongs_to :present_address, :class_name=>"Address", foreign_key: :id
 # belongs_to :permanent_address, :class_name=>"Address", foreign_key: :id
	has_many :addresses  
	belongs_to :education
  belongs_to :ff_status
  belongs_to :role
  belongs_to :grade
  belongs_to :user
  belongs_to :salary
  has_many :promotions
  has_many :educations
  has_many :experiences
	has_many :email_ettiquities, :class_name => "EmailEttiquitie"



  belongs_to :group
  
  has_many :reporting_managers

 	
 	# for file attachments
  has_many :employee_attachments
  accepts_nested_attributes_for :employee_attachments
 	 	
 	has_one :leave
  
  has_many :leave_histories
  
  has_many :educations



	validates :employee_id, presence: true 

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :date_of_birth, presence: true
	#validates :gender, presence: true
  validates :department_id, presence: true

	#validates :designation_id, presence: true
	validates :mobile_number, presence: true, numericality: true , length: { is: 10 }




	validates :father_name, presence: true
	validates :blood_group_id, presence: true
#	validates :grade_id, presence: true
	validates :date_of_join, presence: true
	#validates_format_of :alternate_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message=>"Valid maill id please"
	#validates :alternate_email, presence: true
	

	
	#after_create :add_leaves
	#after_update :update_leaves



  def reporting_manager
    Employee.find(reporting_managers.first.manager_id).full_name if reporting_managers.present?
  end
	
  
  def reporting_manager?
    
    if reporting_managers.present?
      return true
    else
      return false
    end
  end

  def full_name
     "#{first_name} #{last_name}"
  end
	
	def reporting_managerId
	   ReportingManager.find_by_employee_id(id).manager_id
	end

end
