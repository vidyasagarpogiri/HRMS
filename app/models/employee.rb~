class Employee < ActiveRecord::Base
  include Bootsy::Container
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
  has_many :payslips
  belongs_to :shift
  
  has_many :pay_roll_masters


  belongs_to :group
  
  has_many :reporting_managers
  # for investment declartion
  has_many :investment_declarations

  belongs_to :department
 	
 	# for file attachments
  has_many :employee_attachments
  accepts_nested_attributes_for :employee_attachments 	 	
 	has_one :leave
  has_many :leave_histories  
  has_many :educations
  has_many :emergency_contacts
  has_many :appraisals

  has_many :statuses # for employee status, employee may have more than one status so we have kept has_many relationship
  has_many :comments # for employee status comments
  has_many :likes # one status will have one like for one employee

  has_many :projects
  
  #for photo_album
  has_many :albums
  
  #for work groups
  has_many :workgroups_employees 
  has_many :workgroups,  through: :workgroups_employees

  
  #for posts
  has_many :posts
  
  has_many :amzur_events


  has_many :employee_skills
  has_many :skills, :through => :employee_skills
  
  has_many :appraisals, through: :employees_appraisals
  has_many :employees_appraisals
  has_many :employees_reviews
  has_many :employees_appraisal_lists
  has_many :employees_goals
  
	validates :employee_id, presence: true 
	validates :first_name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :last_name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :date_of_birth, presence: true
  validates :department_id, presence: true
	validates :mobile_number, presence: true, numericality: true , length: { maximum: 10, minimum:10 }
	validates :father_name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only allows letters" }
	validates :blood_group_id, presence: true
	validates :date_of_join, presence: true
	validates :alternate_email, presence: true
	
	#For Auditing
	audited
	
	#validates :bank_name, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Plese Enter only  letters" }
	#validates :branch_name, format: { with: /\A[a-zA-Z]+\z/, message: "Plese Enter only  letters" }
	#validates :account_number, numericality: true
	
  #validates :employment_status, presence: true 

	#validates :avatar, presence: true
	#after_create :add_leaves
	#after_update :update_leaves
  #Employment_Status = []

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
  
  #for Devise Ids and Work Shifts
  def self.devise_ids_employees
    devise_ids= []
    Employee.all.each do |emp| 
      if (emp.shift.present? && emp.devise_id.present?) && !emp.status == true
        devise_ids << emp.devise_id
      end
    end
    devise_ids
  end
  
  def is_reporting_manager?
    
   if ReportingManager.where(:manager_id => id).present?
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
	
	def reportees_employees
	  repotees_ids = ReportingManager.where(:manager_id => id).pluck(:employee_id)	  
	  employees = Employee.where(:id => repotees_ids)
	  #@leaves = LeaveHistory.where(:employee_id => @repotees_ids).pluck(:from_date, :to_date)	 
    #@names = Employee.where(:employee_id => @id).pluck(:first_name)
	end
	
	def reportees_leaves
	  @reportee_employees = current_user.employee.reportees_employees
    #raise @reportee_employees.pluck(:employee_id).inspect    
    #@reportee_name = @reportee_employees.pluck(:first_name)
    @leaves = LeaveHistory.where(:employee_id => (@reportee_employees.pluck(:employee_id)), :status => "APPROVED")
	end
	
	def check_appraisal
	  true if EmployeesAppraisal.all.map(&:employee_id).include?(id)
	end

end
