class AmzurEvent < ActiveRecord::Base
  belongs_to :employee  
  
  include Bootsy::Container
  validates :title, presence: true
	validates :description, presence: true
	validates :held_on, presence: true
	
end


