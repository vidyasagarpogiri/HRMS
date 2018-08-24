class JobLocation < ActiveRecord::Base
                              
  has_many :employees         
  belongs_to :address
                    
end                         

