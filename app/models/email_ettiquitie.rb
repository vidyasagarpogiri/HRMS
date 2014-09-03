class EmailEttiquitie < ActiveRecord::Base
	
	belongs_to :employee
	
	validates :ettiquite, presence: true
  validates :dateofsending, presence: true
	
end 

