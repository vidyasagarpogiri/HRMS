class Experience < ActiveRecord::Base
                  
belongs_to :employee                                                 
                                                                                                                                 
validates :previous_company, presence: true
validates :last_designation, presence: true
validates :from_date, presence: true
validates :to_date, presence: true
  
end       
