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
  has_many :departments, :through => :reporting_managers
 	
 	
 	 	
 	 	
 	has_one :leave
  
  has_many :leave_histories



	validates :employee_id, presence: true 
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :date_of_birth, presence: true
	validates :gender, presence: true
  validates :department_id, presence: true
	validates :designation_id, presence: true
	validates :mobile_number, presence: true
	#validates_format_of :mobile_number, with: /\d{3}-\d{3}-\d{4}/, :message => "Please enter Valid Mobile Number"
	validates :father_name, presence: true
	validates :blood_group_id, presence: true
	validates :grade_id, presence: true
	validates :date_of_join, presence: true
	#validates_format_of :alternate_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message=>"Valid maill id please"
	#validates :alternate_email, presence: true
	
	
	#after_create :add_leaves
	#after_update :update_leaves
	
  
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

private
	def add_leaves
		@leave_policy = self.group.leave_policy
		@leave = leave.create(:pl_carry_forward_prev_year => @leave_policy.eligible_carry_forward_leaves, :pl_applied => @leave_policy.pl_this_year, :sl_applied=> @leave_policy.sl_this_year)
	end
	
	def update_leaves
		@leave_policy = group.leave_policy
	
		#leave.update(:pl_carry_forward_prev_year => @leave_policy.eligible_carry_forward_leaves, :pl_applied => @leave_policy.pl_this_year, :sl_applied=> @leave_policy.sl_this_year)
	end
	

end
