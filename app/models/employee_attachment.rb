class EmployeeAttachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :employee
  
  #Attachment Validations
  #validates :attachment, presence: true
	#validates :attachment_name, presence: true
	
end
