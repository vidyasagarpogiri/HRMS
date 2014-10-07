class AmzurEvent < ActiveRecord::Base

  validates :title, presence: true
	validates :description, presence: true
	validates :held_on, presence: true
	
end


