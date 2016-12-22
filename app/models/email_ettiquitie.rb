class EmailEttiquitie < ActiveRecord::Base
	
	belongs_to :employee
	validates :ettiquite, presence: true
	
end 

