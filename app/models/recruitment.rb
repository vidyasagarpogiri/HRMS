class Recruitment < ActiveRecord::Base

  include Bootsy::Container
  mount_uploader :file, JobAttachmentUploader
  
  
  validates :link, presence: true
end