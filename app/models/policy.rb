# This model is for policy
class Policy < ActiveRecord::Base
  include Bootsy::Container
  mount_uploader :document, PolicyDocumentUploader
end
