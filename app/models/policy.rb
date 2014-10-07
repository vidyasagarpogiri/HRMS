class Policy < ActiveRecord::Base
  mount_uploader :document, PolicyDocumentUploader
end
