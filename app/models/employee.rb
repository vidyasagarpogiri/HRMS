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
	validates :first_name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :last_name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :date_of_birth, presence: true
  validates :department_id, presence: true
	validates :mobile_number, presence: true, numericality: true , length: { maximum: 10, minimum:10 }
	validates :father_name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :blood_group_id, presence: true
	validates :date_of_join, presence: true
	#validates :avatar, presence: true
  

	
	#after_create :add_leaves
	#after_update :update_leaves



 def reporting_manager
     if reporting_managers.first.present? && reporting_managers.first.manager_id.present? 
      Employee.find(reporting_managers.first.manager_id).full_name  unless reporting_managers.first.manager_id == 0 
    end
  end
	
	
	def reporting_manager_user
	  if reporting_managers.first.present? && reporting_managers.first.manager_id.present? 
      Employee.find(reporting_managers.first.manager_id).user.email  unless reporting_managers.first.manager_id == 0 
    end
	end
  
  def reporting_manager? 
    if reporting_managers.present?
      return true
    else
      return false 
    end
  end
  
  
  def is_reporting_manager?
    
    if reporting_managers.present?
      if reporting_managers.first.manager_id==id
        return true
      else
        return false
      end
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
