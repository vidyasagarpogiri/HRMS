class AmzurEvent < ActiveRecord::Base
  include Bootsy::Container
  validates :title, presence: true
	validates :description, presence: true
	validates :held_on, presence: true
	
end


