class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader
	belongs_to	:album # Photo belongs to Album
	validates :album_id, presence: true # Validation for album_id
	validates :image, presence: true # Validation for image
end
