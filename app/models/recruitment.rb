class Recruitment < ActiveRecord::Base
  mount_uploader :file, JobAttachmentUploader
end


