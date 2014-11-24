class Album < ActiveRecord::Base
  mount_uploader :album, AvatarUploader
  belongs_to :employee
  has_many :photos
  accepts_nested_attributes_for :photos
end
